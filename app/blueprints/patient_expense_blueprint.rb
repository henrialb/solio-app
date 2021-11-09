class PatientExpenseBlueprint < Blueprinter::Base
  identifier :id

  fields :description, :amount, :note, :date, :patient_file_id
end
