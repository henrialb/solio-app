class PatientBlueprint < Blueprinter::Base
  identifier :id

  # TODO: make LowerCamelTransformer work (in app/lib)

  # fields :name, :dob, :sex, :full_name, :full_name, :is_active, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag
  fields :name, :dob, :sex

  field :full_name, name: :fullName
  field :is_active, name: :isActive
  field :citizen_no, name: :citizenNo
  field :nif_no, name: :nifNo
  field :health_no, name: :healthNo
  field :social_security_no, name: :socialSecurityNo
  field :clothes_tag, name: :clothesTag
end
