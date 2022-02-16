class PatientExit < ApplicationRecord
  belongs_to :patient_admission

  validates :date, presence: true
end
