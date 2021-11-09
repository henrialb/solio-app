class PatientAdmission < ApplicationRecord
  belongs_to :patient
  has_many :patient_files, dependent: :destroy

  validates :date, presence: true
end
