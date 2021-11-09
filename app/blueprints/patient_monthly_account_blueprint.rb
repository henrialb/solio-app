class PatientMonthlyAccountBlueprint < Blueprinter::Base
  identifier :id

  fields :patient_file_id, :month, :total, :is_paid
end
