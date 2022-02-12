class ChangePatientReceivables < ActiveRecord::Migration[6.1]
  def change
    rename_column :patient_receivables, :total, :amount
    remove_column :patient_receivables, :month
  end
end
