class ChangePatientExpenses < ActiveRecord::Migration[6.1]
  def change
    t.references :patient, null: false, foreign_key: true
    t.references :patient_receivable, foreign_key: true
  end
end
