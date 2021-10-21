class PatientMonthlyAccount < ApplicationRecord
  belongs_to :patient_file

  validates :month, :total, presence: true
  validates :total, numericality: true
end
