class PatientBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :dob, :address, :phone, :email, :role, :nationality

  field :full_name, name: :fullName
  field :is_active, name: :isActive
  field :citizen_no, name: :citizenNo
  field :nif_no, name: :nifNo
  field :health_no, name: :healthNo  
end

