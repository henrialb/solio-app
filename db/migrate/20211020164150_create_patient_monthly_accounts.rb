class CreatePatientMonthlyAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_monthly_accounts do |t|
      t.references :patient_file, null: false, foreign_key: true
      t.date :month
      t.decimal :total
      t.integer :is_paid

      t.timestamps
    end
  end
end
