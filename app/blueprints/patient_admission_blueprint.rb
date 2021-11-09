class PatientAdmissionBlueprint < Blueprinter::Base
  identifier :id

  fields :date, :patient_id
end
