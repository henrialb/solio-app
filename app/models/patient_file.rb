class PatientFile < ApplicationRecord
  belongs_to :patient_admission
  belongs_to :patient
  has_many :patient_expenses, dependent: :destroy
  has_many :patient_receivables, dependent: :destroy

  validates :open_date, presence: true
end
