class PatientPaymentsController < ApplicationController
  include ReceivablePayable

  before_action :set_patient_payment, only: %i[show update destroy]

  def index
    @patient_payments = PatientPayment.all.includes(:patient_receivables)
    render json: PatientPaymentBlueprint.render(@patient_payments)
  end

  def create
    @patient_payment = PatientPayment.new(patient_payment_params)

    if @patient_payment.save
      patient = Patient.find(@patient_payment.patient_id)
      funds = @patient_payment.amount + patient.balance

      pay_outstanding_receivables(patient, funds, @patient_payment.id)

      render json: PatientPaymentBlueprint.render(@patient_payment)
    else
      render json: @patient_payment.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: PatientPaymentBlueprint.render(@patient_payment)
  end

  # def update
  #   if @patient_payment.update(patient_payment_params)
  #     render json: PatientPaymentBlueprint.render(@patient_payment)
  #   else
  #     render json: @patient_payment.errors, status: :unprocessable_entity
  #   end
  # end

  def destroy
    patient = Patient.find(@patient_payment.patient_id)
    patient_balance = patient.balance

    receivables = PatientReceivable.where(patient_payment_id: @patient_payment)
    total_receivables = receivables.sum(:amount)
    receivables.update_all(status: :unpaid, patient_payment_id: nil)

    if @patient_payment.amount <= total_receivables
      additional_funds = total_receivables - @patient_payment.amount
    else
      excess_payment = @patient_payment.amount - total_receivables # the part of the payment amount that went into balance

      if patient_balance >= excess_payment
        additional_funds = excess_payment * -1
      else
        used_excess_payment = excess_payment - patient_balance # the part of payment amount that went into balance and was later used to partially pay a receivable
        paid_receivables = PatientReceivable.where(patient_id: patient).paid.order(created_at: :desc)
        total_paid_receivables = 0

        ActiveRecord::Base.transaction do
          paid_receivables.each do |receivable|
            receivable.update(status: :unpaid, patient_payment_id: nil)
            total_paid_receivables += receivable.amount

            break unless total_paid_receivables < used_excess_payment
          end

          additional_funds = total_paid_receivables - used_excess_payment - patient_balance
        end
      end
    end

    pay_outstanding_receivables(patient, additional_funds) if @patient_payment.amount != total_receivables

    @patient_payment.destroy
  end

  private

  def set_patient_payment
    @patient_payment = PatientPayment.find(params[:id])
  end

  def patient_payment_params
    params.require(:patient_payment).permit(:patient_id, :amount, :method, :accountable, :date, :note)
  end
end
