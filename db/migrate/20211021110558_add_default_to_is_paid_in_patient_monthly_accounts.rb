class AddDefaultToIsPaidInPatientMonthlyAccounts < ActiveRecord::Migration[6.1]
  def change
    change_column :patient_monthly_accounts, :is_paid, :integer, default: 0, null: false
  end
end
