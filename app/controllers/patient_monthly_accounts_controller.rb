class PatientMonthlyAccountsController < ApplicationController
  before_action :set_patient_monthly_account, only: %i[show update destroy]

  def index
    @patient_monthly_accounts = PatientMonthlyAccount.all
    render json: PatientMonthlyAccountBlueprint.render(@patient_monthly_accounts)
  end

  def create
    @patient_monthly_account = PatientMonthlyAccount.new(patient_monthly_account_params)
    if @patient_monthly_account.save
      render json: PatientMonthlyAccountBlueprint.render(@patient_monthly_account)
    else
      render json: @patient_monthly_account.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: PatientMonthlyAccountBlueprint.render(@patient_monthly_account)
  end

  def update
    if @patient_monthly_account.update(patient_monthly_account_params)
      render json: PatientMonthlyAccountBlueprint.render(@patient_monthly_account)
    else
      render json: @patient_monthly_account.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @patient_monthly_account.destroy
  end

  private

  def set_patient_monthly_account
    @patient_monthly_account = PatientMonthlyAccount.find(params[:id])
  end

  def patient_monthly_account_params
    params.require(:patient_monthly_account).permit(:patient_file_id, :month, :total, :is_paid)
  end
end
