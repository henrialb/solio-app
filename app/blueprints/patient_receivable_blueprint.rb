class PatientReceivableBlueprint < Blueprinter::Base
  identifier :id

  fields :patient_file_id, :patient_id, :amount, :description, :accountable, :source, :status, :patient_payment_id

  field :expenses do |receivable|
    receivable.patient_expenses.ids if receivable.patient_expenses.exists?
  end
end
