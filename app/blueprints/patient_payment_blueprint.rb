class PatientPaymentBlueprint < Blueprinter::Base
  identifier :id

  fields :patient_id, :amount, :date, :note
end
