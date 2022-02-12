class PatientPayment < ApplicationRecord
  belongs_to :patient
  has_many :patient_receivables

  validates :amount, presence: true
end
