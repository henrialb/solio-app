class PatientPaymentBlueprint < Blueprinter::Base
  identifier :id

  fields :patient_id, :amount, :method, :date, :accountable, :note

  field :receivables_paid do |patient_payment|
    patient_payment.patient_receivables.ids if patient_payment.patient_receivables.exists?
  end
end
