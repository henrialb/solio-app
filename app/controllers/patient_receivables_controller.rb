class PatientReceivablesController < ApplicationController
  before_action :set_patient_receivable, only: %i[show update destroy]

  def index
    @patient_receivables = PatientReceivable.all
    render json: PatientReceivableBlueprint.render(@patient_receivables)
  end

  def create
    @patient_receivable = PatientReceivable.new(patient_receivable_params)

    expenses = PatientExpense.where(patient_id: @patient_receivable.patient_id, patient_receivable_id: nil)

    amount = 0

    expenses.each do |expense|
      amount += expense.amount
    end

    @patient_receivable.amount = amount

    if @patient_receivable.save
      expenses.each do |expense|
        expense.patient_receivable_id = @patient_receivable.id
        expense.save
      end
      render json: PatientReceivableBlueprint.render(@patient_receivable)
    else
      render json: @patient_receivable.errors, status: :unprocessable_entity
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
    params.require(:patient_receivable).permit(:patient_file_id, :patient_id, :description, :is_paid, :patient_payment_id)
  end
end
