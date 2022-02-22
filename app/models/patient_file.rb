class PatientFile < ApplicationRecord
  belongs_to :patient_admission
  has_many :patient_expenses, dependent: :destroy
  has_many :patient_receivables, dependent: :destroy

  validates :open_date, presence: true
  validates :close_date, comparison: { greater_than_or_equal_to: :open_date }, allow_nil: true
end
