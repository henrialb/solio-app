class PatientExpense < ApplicationRecord
  belongs_to :patient_file

  validates :amount, numericality: true
  validates :date, :amount, presence: true
end
