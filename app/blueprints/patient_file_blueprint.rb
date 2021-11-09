class PatientFileBlueprint < Blueprinter::Base
  identifier :id

  fields :note, :patient_admission_id, :open_date, :close_date
end
