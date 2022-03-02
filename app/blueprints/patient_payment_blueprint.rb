class PatientPaymentBlueprint < Blueprinter::Base
  identifier :id

  fields :patient_id, :amount, :method, :date, :note
end
