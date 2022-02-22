class PatientExpense < ApplicationRecord
  belongs_to :patient_file
  belongs_to :patient
  belongs_to :patient_receivable, optional: true

  validates :amount, numericality: { greater_than: 0 }
  validates :date, :amount, :description, presence: true
end
