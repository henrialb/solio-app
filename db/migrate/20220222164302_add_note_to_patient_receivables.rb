class AddNoteToPatientReceivables < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_receivables, :note, :string
  end
end
