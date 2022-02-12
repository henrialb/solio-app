class ChangePatientExpenses < ActiveRecord::Migration[6.1]
  def change
    add_reference :patient_expenses, :patient, foreign_key: true
    add_reference :patient_expenses, :patient_receivable, foreign_key: true
  end
end
