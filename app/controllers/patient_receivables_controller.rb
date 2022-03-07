class PatientReceivablesController < ApplicationController
  before_action :set_patient_receivable, only: %i[show update destroy]

  def index
    @patient_receivables = PatientReceivable.all
    render json: PatientReceivableBlueprint.render(@patient_receivables)
  end

  def create
    @patient_receivable = PatientReceivable.new(patient_receivable_params)

    if @patient_receivable.save
      render json: PatientReceivableBlueprint.render(@patient_receivable)
    else
      render json: @patient_receivable.errors, status: :unprocessable_entity
    end
  end

  def create_from_expenses
    @patient_receivable = PatientReceivable.new(patient_receivable_params)
    expenses = PatientExpense.where(patient_id: @patient_receivable.patient_id, patient_receivable_id: nil)
    @patient_receivable.amount = expenses.sum(:amount)

    if @patient_receivable.save
      expenses.update_all(patient_receivable_id: @patient_receivable.id)
      render json: PatientReceivableBlueprint.render(@patient_receivable)
    else
      render json: @patient_receivable.errors, status: :unprocessable_entity
    end
  end

  def create_from_monthly_fee
    patients = Patient.active
    date_dictionary = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro']

    @patient_receivable = []

    patients.each do |patient|
      monthly_fee_receivable_params = {
        patient_id: patient.id,
        patient_file_id: patient.patient_files.last.id,
        status: :unpaid,
        description: "Mensalidade #{date_dictionary[Date.today.month - 1]}"
      }

      if patient.scml?
        @patient_receivable << PatientReceivable.new(
          monthly_fee_receivable_params.merge(
            description: "Mensalidade #{date_dictionary[Date.today.month - 1]} – SCML",
            amount: PatientReceivable.where(patient_id: patient.id).where("description LIKE ?", "Mensalidade%SCML").last.amount
          )
        )

        @patient_receivable << PatientReceivable.new(
          monthly_fee_receivable_params.merge(
            amount: patient.monthly_fee - @patient_receivable[0].amount
          )
        )
      else
        @patient_receivable << PatientReceivable.new(
          monthly_fee_receivable_params.merge(
            amount: patient.monthly_fee
          )
        )
      end
    end

    if @patient_receivable.each { |receivable| receivable.save }
      render json: PatientReceivableBlueprint.render(@patient_receivable.each { |receivable| receivable })
    else
      render json: @patient_receivable.each { |receivable| receivable.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: PatientReceivableBlueprint.render(@patient_receivable)
  end

  def update
    if @patient_receivable.update(patient_receivable_params)
      render json: PatientReceivableBlueprint.render(@patient_receivable)
    else
      render json: @patient_receivable.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @patient_receivable.destroy
  end

  private

  def set_patient_receivable
    @patient_receivable = PatientReceivable.find(params[:id])
  end

  def patient_receivable_params
    params.require(:patient_receivable).permit(:patient_file_id, :patient_id, :description, :amount, :status, :note, :patient_payment_id)
  end
end
