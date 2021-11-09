class PatientBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :dob, :sex, :full_name, :full_name, :is_active, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag
end
