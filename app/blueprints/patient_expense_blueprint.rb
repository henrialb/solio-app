class PatientExpenseBlueprint < Blueprinter::Base
  identifier :id

  fields :description, :amount, :note, :date, :patient_file_id, :patient_id, :patient_receivable_id

  field :receivable_status do |patient_expense|
    patient_expense.patient_receivable.status unless patient_expense.patient_receivable.nil?
  end
end
