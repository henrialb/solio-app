class EmployeeBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :dob, :address, :phone, :email, :role, :nationality, :user_id, :full_name, :is_active, :citizen_no, :nif_no, :health_no
end
