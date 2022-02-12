class PatientExpense < ApplicationRecord
  belongs_to :patient_file
  belongs_to :patient
  belongs_to :patient_receivable, optional: true

  validates :amount, numericality: true
  validates :date, :amount, :description, presence: true
end
