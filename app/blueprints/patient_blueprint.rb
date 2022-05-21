include Rails.application.routes.url_helpers

class PatientBlueprint < Blueprinter::Base

  identifier :id

  fields :name, :date_of_birth, :sex, :full_name, :full_name, :status, :citizen_num, :nif_num, :health_num, :social_security_num, :clothes_tag, :monthly_fee, :balance, :covenant

  field :files do |patient|
    patient.patient_files.ids if patient.patient_files.exists?
  end

  field :facility do |patient|
    patient.patient_files.last.facility if patient.active?
  end

  field :profile_photo do |patient|
    rails_blob_url(patient.profile_photo) if patient.profile_photo.attached?
  end
end
