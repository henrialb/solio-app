class PatientAdmission < ApplicationRecord
  belongs_to :patient
  has_many :patient_files, dependent: :destroy
  has_one :patient_exit, dependent: :destroy

  validates_with PatientAdmissionValidator, on: :create

  validates :date, presence: true
end
