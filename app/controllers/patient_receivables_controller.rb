class PatientReceivablesController < ApplicationController
  before_action :set_patient_receivable, only: %i[show update destroy]

  def index
    @patient_receivables = PatientReceivable.all.includes(:patient_expenses)
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
    @monthly_fee_receivables = []

    patients.each do |patient|
      monthly_fee_receivable_params = {
        patient_id: patient.id,
        patient_file_id: patient.patient_files.last.id,
        status: :unpaid,
        description: "Mensalidade #{date_dictionary[Date.today.month - 1]}"
      }

      if patient.scml?
        @monthly_fee_receivables << PatientReceivable.new(
          monthly_fee_receivable_params.merge(
            description: "Mensalidade #{date_dictionary[Date.today.month - 1]} – SCML",
            amount: PatientReceivable.where(patient_id: patient.id).scml.last.amount
          )
        )

        @monthly_fee_receivables << PatientReceivable.new(
          monthly_fee_receivable_params.merge(
            amount: patient.monthly_fee - @monthly_fee_receivables.last.amount
          )
        )
      else
        @monthly_fee_receivables << PatientReceivable.new(
          monthly_fee_receivable_params.merge(
            amount: patient.monthly_fee
          )
        )
      end

      # Create receivable as paid if patient has enough balance (only personal portion of monthly fee – not SCML)
      if patient.balance >= @monthly_fee_receivables.last.amount
        @monthly_fee_receivables.last.status = :paid
      end
    end

    ActiveRecord::Base.transaction do
      @monthly_fee_receivables.each do |receivable|
        if receivable.paid?
          patient = Patient.find(receivable.patient_id)

          patient.update(balance: patient.balance - receivable.amount)
        end

        receivable.save
      end
    end
  end

  def show
    render json: PatientReceivableBlueprint.render(@patient_receivable)
  end

  def update
    params = patient_receivable_params

    ActiveRecord::Base.transaction do
      if @patient_receivable.description.upcase.include? "SCML"
        unless params[:amount].nil? || params[:amount] == @patient_receivable.amount
          # Change amount for personal portion of monthly fee
          personal_fee_receivable = PatientReceivable.find(@patient_receivable.id + 1)
          personal_fee_receivable.amount -= params[:amount] - @patient_receivable.amount

          personal_fee_receivable.save
        end

        if @patient_receivable.unpaid? && params[:status] == 1 # status 1 = :paid
          # Create patient_payment
          require 'date'

          payment = PatientPayment.new(patient_id: @patient_receivable.patient.id, amount: @patient_receivable.amount, method: :bank_transfer, date: Date.today)

          # Add patient_payment_id to params
          params.merge!(patient_payment_id: payment.id) if payment.save
        end
      end

      if @patient_receivable.update(params)
        render json: PatientReceivableBlueprint.render(@patient_receivable)
      else
        render json: @patient_receivable.errors, status: :unprocessable_entity
      end
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
