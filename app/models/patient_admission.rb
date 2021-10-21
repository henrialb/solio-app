class PatientAdmission < ApplicationRecord
  belongs_to :patient

  validates :date, presence: true
end
