class PatientReceivable < ApplicationRecord
  has_many :patient_expenses
  belongs_to :patient
  belongs_to :patient_file
  belongs_to :patient_payment, optional: true

  validates :amount, presence: true
  validates :amount, numericality: true
end
