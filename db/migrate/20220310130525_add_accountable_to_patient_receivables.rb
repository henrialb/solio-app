class AddAccountableToPatientReceivables < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_receivables, :accountable, :integer, default: 0, null: false
    add_column :patient_receivables, :source, :integer, default: 2, null: false
    add_column :patient_payments, :accountable, :integer, default: 0, null: false
  end
end
