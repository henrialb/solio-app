class PatientReceivableBlueprint < Blueprinter::Base
  identifier :id

  fields :patient_file_id, :patient_id, :amount, :description, :is_paid, :patient_payment_id
end