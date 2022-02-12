class RenamePatientMonthlyAccountsToPatientReceivables < ActiveRecord::Migration[6.1]
  def change
    rename_table :patient_monthly_accounts, :patient_receivables
  end
end
