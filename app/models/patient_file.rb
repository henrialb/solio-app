class PatientFile < ApplicationRecord
  belongs_to :patient_admission

  validates :open_date, presence: true
end
