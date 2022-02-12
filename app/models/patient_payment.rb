class PatientPayment < ApplicationRecord
  has_many :patient_receivables
  belongs_to :patient

  validates :amount, presence: true
end
