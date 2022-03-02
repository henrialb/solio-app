class RenameIsPaidToStatusInPatientReceivables < ActiveRecord::Migration[7.0]
  def change
    change_column :patient_receivables, :is_paid, :integer, default: 0
    rename_column :patient_receivables, :is_paid, :status
  end
end
