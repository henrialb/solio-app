class PatientAdmissionBlueprint < Blueprinter::Base
  identifier :id

  fields :date

  field :patient_id, name: :patientId
end
