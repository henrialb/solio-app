class AddDefaultToIsPaidInPatientMonthlyAccounts < ActiveRecord::Migration[6.1]
  def change
    change_column :patient_monthly_accounts, :is_paid, :boolean, default: false
  end
end
