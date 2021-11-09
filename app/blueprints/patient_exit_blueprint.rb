class PatientExitBlueprint < Blueprinter::Base
  identifier :id

  fields :patient_admission_id, :date, :reason, :location, :note
end
