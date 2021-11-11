class AddScaleToTotalInPatientMonthlyAccounts < ActiveRecord::Migration[6.1]
  def change
    change_column :patient_monthly_accounts, :total, :decimal, precision: 6 ,scale: 2
  end
end
