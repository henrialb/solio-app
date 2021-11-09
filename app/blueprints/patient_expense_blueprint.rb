class PatientExpenseBlueprint < Blueprinter::Base
  identifier :id

  fields :description, :amount, :note, :date

  field :patient_file_id, name: :patientFileId
end
