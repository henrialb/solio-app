class PatientReceivablesController < ApplicationController
  include ReceivablePayable

  before_action :set_patient_receivable, only: %i[show update destroy]

  def index
    @patient_receivables = PatientReceivable.all.includes(:patient_expenses)
    render json: PatientReceivableBlueprint.render(@patient_receivables)
  end

  def patient
    patient = params[:id]
    @patient_receivables = PatientReceivable.where(patient_id: patient).reverse_order
    render json: PatientReceivableBlueprint.render(@patient_receivables)
  end

  def create
    @patient_receivable = PatientReceivable.new(patient_receivable_params)

    pay_receivable_from_balance

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

    pay_receivable_from_balance

    @patient_receivable.patient_file_id = @patient.patient_files.last.id

    if @patient_receivable.save
      expenses.update_all(patient_receivable_id: @patient_receivable.id)
      render json: PatientReceivableBlueprint.render(@patient_receivable)
    else
      render json: @patient_receivable.errors, status: :unprocessable_entity
    end
  end

  def create_from_monthly_fee
    patients = Patient.active.includes(:patient_files, :patient_receivables)
    date_dictionary = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro']
    @monthly_fee_receivables = []
    month = Date.today.day < 20 ? date_dictionary[Date.today.month - 1] : date_dictionary[Date.today.month]

    patients.each do |patient|
      monthly_fee_receivable_params = {
        patient: patient,
        patient_file: patient.patient_files.last,
        status: :unpaid,
        source: :monthly_fee,
        accountable: :personal,
        description: "Mensalidade #{month}"
      }

      if patient.scml?
        previous_scml_receivable = patient.patient_receivables.scml.last

        @monthly_fee_receivables << PatientReceivable.new(
          monthly_fee_receivable_params.merge(
            description: "Mensalidade #{month} – SCML",
            amount: !previous_scml_receivable.nil? ? previous_scml_receivable.amount : 1000,
            accountable: :scml
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
        @monthly_fee_receivables.last.status = :paid if @monthly_fee_receivables.last.personal?
      end
    end

    ActiveRecord::Base.transaction do
      @monthly_fee_receivables.each do |receivable|
        patient = receivable.patient
        patient.update(balance: patient.balance - receivable.amount) if receivable.paid?

        receivable.save if receivable.amount.positive?
      end
    end
  end

  def show
    render json: PatientReceivableBlueprint.render(@patient_receivable)
  end

  def update
    params = patient_receivable_params

    ActiveRecord::Base.transaction do
      if @patient_receivable.scml?
        unless params[:amount].nil? || params[:amount] == @patient_receivable.amount
          # Change amount for personal portion of monthly fee
          personal_fee_receivable = PatientReceivable.find(@patient_receivable.id + 1)

          payment_difference = @patient_receivable.amount - params[:amount]

          if personal_fee_receivable.paid? # Personal portion of the fee was already paid
            patient = personal_fee_receivable.patient

            if payment_difference.positive?
              # Personal portion of the fee increases
              if patient.balance >= payment_difference
                # There is enough balance to cover the difference
                patient.balance -= payment_difference

                patient.save
              else
                personal_fee_receivable.status = :unpaid

                # Use amount of personal_fee_receivable as additional funds to patient balance, to pay outstanding receivables
                pay_outstanding_receivables(patient, personal_fee_receivable.amount)
              end
            else
              # Personal portion of the fee decreases, difference goes into additional funds to pay outstanding receivables
              pay_outstanding_receivables(patient, payment_difference.abs)
            end
          end

          personal_fee_receivable.amount += payment_difference

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
    if @patient_receivable.source == 'expenses'
      expenses = PatientExpense.where(patient_receivable_id: @patient_receivable.id)

      ActiveRecord::Base.transaction do
        expenses.update_all(patient_receivable_id: nil)

        if @patient_receivable.paid?
          patient = @patient_receivable.patient
          patient.update(balance: patient.balance += @patient_receivable.amount)
        end

        @patient_receivable.destroy
      end
    else
      @patient_receivable.destroy if @patient_receivable.unpaid?
    end
  end

  private

  def set_patient_receivable
    @patient_receivable = PatientReceivable.find(params[:id])
  end

  def patient_receivable_params
    params.require(:patient_receivable).permit(:patient_file_id, :patient_id, :description, :amount, :source, :expenses, :accountable, :status, :note, :patient_payment_id)
  end

  def pay_receivable_from_balance
    @patient = Patient.find(@patient_receivable.patient_id)

    if @patient.balance >= @patient_receivable.amount
      @patient_receivable.status = 'paid' if @patient.balance >= @patient_receivable.amount
      @patient.update(balance: @patient.balance - @patient_receivable.amount)
    end
  end
end
