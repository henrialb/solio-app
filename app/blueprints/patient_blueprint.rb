class PatientBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :dob, :sex, :full_name, :full_name, :status, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag, :monthly_fee, :balance, :covenant

  field :file_id do |patient|
    patient.patient_files.last.id if patient.patient_files.exists?
  end
end
