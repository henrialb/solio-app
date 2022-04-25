include Rails.application.routes.url_helpers

class PatientBlueprint < Blueprinter::Base

  identifier :id

  fields :name, :dob, :sex, :full_name, :full_name, :status, :citizen_no, :nif_no, :health_no, :social_security_no, :clothes_tag, :monthly_fee, :balance, :covenant

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
