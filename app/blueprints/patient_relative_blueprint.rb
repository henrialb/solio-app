class PatientRelativeBlueprint < Blueprinter::Base
  identifier :id

  fields :patient_id, :name, :relationship, :phone, :email, :address, :is_main, :note
end
