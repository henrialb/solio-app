class PatientFileBlueprint < Blueprinter::Base
  identifier :id

  fields :patient_admission_id, :facility, :open_date, :close_date, :note
end
