class PatientPayment < ApplicationRecord
  has_many :patient_receivables
  belongs_to :patient

  validates :amount, :method, presence: true

  enum method: [:bank_transfer, :cash, :multibanco, :vale, :bitcoin]
end
