class RenameIsPaidToStatusInPatientReceivables < ActiveRecord::Migration[7.0]
  def change
    rename_column :patient_receivables, :is_paid, :status
  end
end
