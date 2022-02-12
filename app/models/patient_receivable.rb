class PatientReceivable < ApplicationRecord
  belongs_to :patient
  belongs_to :patient_file
  belongs_to :patient_payment, optional: true

  validates :amount, presence: true
  validates :amount, numericality: true
end
