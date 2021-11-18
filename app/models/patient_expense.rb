class PatientExpense < ApplicationRecord
  belongs_to :patient_file
  belongs_to :patient_admission
  belongs_to :patient

  validates :amount, numericality: true
  validates :date, :amount, presence: true
end
