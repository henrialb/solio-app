class PatientExit < ApplicationRecord
  belongs_to :patient_admission
  belongs_to :patient

  validates :date, presence: true
end
