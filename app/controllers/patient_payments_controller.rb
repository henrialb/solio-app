class PatientPaymentsController < ApplicationController
  before_action :set_patient_payment, only: %i[show update destroy]

  def index
    @patient_payments = PatientPayment.all
    render json: PatientPaymentBlueprint.render(@patient_payments)
  end

  def create
    @patient_payment = PatientPayment.new(patient_payment_params)

    if @patient_payment.save
      patient = Patient.find(@patient_payment.patient_id)
      funds = @patient_payment.amount + patient.balance

      # unpaid_receivables = PatientReceivable.where(patient_id: patient).unpaid.order(amount: :asc)
      # unpaid_receivables.each do |receivable|
      #   if receivable.amount <= funds
      #     receivable.update(status: "paid", patient_payment_id: @patient_payment.id)
      #     funds -= receivable.amount
      #   else
      #     break
      #   end
      # end

      updated_patient_balance = pay_outstanding_receivables(patient, funds, @patient_payment) # precisa .id?

      patient.update(balance: updated_patient_balance) if updated_patient_balance != patient.balance

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
    patient = Patient.find(@patient_payment.patient_id)
    patient_balance = patient.balance
    receivables = PatientReceivable.where(patient_payment_id: @patient_payment)
    total_receivables = receivables.sum(:amount)
    receivables.update_all(status: :unpaid, patient_payment_id: nil)

    if @patient_payment.amount <= total_receivables
      funds = patient_balance + total_receivables - @patient_payment.amount
    else
      excess_payment = @patient_payment.amount - total_receivables # the part of the payment amount that went into balance

      if patient_balance >= excess_payment
        funds = patient_balance - excess_payment
      else
        used_excess_payment = excess_payment - patient_balance # the part of payment amount that went into balance and later was used to partially pay a receivable
        paid_receivables = PatientReceivable.where(patient_id: patient).paid.order(created_at: :desc)
        total_paid_receivables = 0

        paid_receivables.each do |receivable|
          receivable.update(status: :unpaid, patient_payment_id: nil)
          total_paid_receivables += receivable.amount

          break if total_paid_receivables >= used_excess_payment
        end

        funds = total_paid_receivables - used_excess_payment
      end
    end

    updated_patient_balance = @patient_payment.amount != total_receivables ? pay_outstanding_receivables(patient, funds) : funds

    patient.update(balance: updated_patient_balance) if updated_patient_balance != patient_balance

    @patient_payment.destroy
  end

  private

  def set_patient_payment
    @patient_payment = PatientPayment.find(params[:id])
  end

  def patient_payment_params
    params.require(:patient_payment).permit(:patient_id, :amount, :method, :date, :note)
  end

  # def pay_outstanding_receivables(patient, funds, patient_payment_id = nil)
  #   PatientReceivable.where(patient_id: patient).unpaid.order(amount: :asc).each do |receivable|
  #     receivable_amount = receivable.amount
  #     if funds >= receivable_amount
  #       receivable.update(status: "paid", patient_payment_id: patient_payment_id)
  #       funds -= receivable_amount
  #     else
  #       funds
  #       break
  #     end
  #   end
  # end

  def pay_outstanding_receivables(patient, funds, patient_payment_id = nil)
    receivables = PatientReceivable.where(patient_id: patient).unpaid.order(amount: :asc)

    ActiveRecord::Base.transaction do
      receivables.each do |receivable|
        break if funds < receivable.amount

        receivable.update(status: :paid, patient_payment_id: patient_payment_id)
        funds -= receivable.amount
      end
    end

    funds
  end
end
