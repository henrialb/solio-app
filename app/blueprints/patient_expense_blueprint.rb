class PatientExpenseBlueprint < Blueprinter::Base
  identifier :id

  fields :description, :amount, :note, :date, :patient_file_id, :patient_id, :patient_receivable_id
end
