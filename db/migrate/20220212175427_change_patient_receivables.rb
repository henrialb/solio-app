class ChangePatientReceivables < ActiveRecord::Migration[6.1]
  def change
    rename_column :patient_receivables, :total, :amount
    remove_column :patient_receivables, :month
    add_reference :patient_receivables, :patient, foreign_key: true
    add_column :patient_receivables, :description, :string
    add_reference :patient_receivables, :patient_payment, foreign_key: true
  end
end
