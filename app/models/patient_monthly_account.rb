class PatientMonthlyAccount < ApplicationRecord
  belongs_to :patient_file
  belongs_to :patient_admission
  belongs_to :patient

  validates :month, :total, presence: true
  validates :total, numericality: true
end
