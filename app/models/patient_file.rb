class PatientFile < ApplicationRecord
  belongs_to :patient_admission
  has_many :patient_expenses, dependent: :destroy
  has_many :patient_receivables, dependent: :destroy

  validates_with PatientFileValidator, on: :create

  validates :open_date, presence: true
  validates :close_date, comparison: { greater_than_or_equal_to: :open_date }, allow_nil: true

  enum facility: [:'36', :'21']
end
