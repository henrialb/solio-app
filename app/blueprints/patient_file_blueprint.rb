class PatientFileBlueprint < Blueprinter::Base
  identifier :id

  fields :note

  field :patient_admission_id, name: :patientAdmissionId
  field :open_date, name: :openDate
  field :close_date, name: :closeDate
end
