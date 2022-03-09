class PatientBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :dob, :sex, :full_name, :full_name, :status, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag, :monthly_fee, :balance, :covenant

  field :files do |patient|
    patient.patient_files.ids if patient.patient_files.exists?
  end
end
