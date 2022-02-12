class PatientPayment < ApplicationRecord
  belongs_to :patient

  validates :amount, presence: true
end
