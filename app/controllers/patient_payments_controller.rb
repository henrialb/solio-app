class PatientPaymentsController < ApplicationController
  before_action :set_patient_payment, only: %i[show update destroy]

  def index
    @patient_payments = PatientPayment.all
    render json: PatientPaymentBlueprint.render(@patient_payments)
  end

  def create
    @patient_payment = PatientPayment.new(patient_payment_params)
    if @patient_payment.save
      render json: PatientPaymentBlueprint.render(@patient_payment)
    else
      render json: @patient_payment.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: PatientPaymentBlueprint.render(@patient_payment)
  end

  def update
    if @patient_payment.update(patient_payment_params)
      render json: PatientPaymentBlueprint.render(@patient_payment)
    else
      render json: @patient_payment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @patient_payment.destroy
  end

  private

  def set_patient_payment
    @patient_payment = PatientPayment.find(params[:id])
  end

  def patient_payment_params
    params.require(:patient_payment).permit(:patient_id, :amount, :method, :date, :note)
  end
end
