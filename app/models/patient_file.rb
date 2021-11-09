class PatientFile < ApplicationRecord
  belongs_to :patient_admission
  has_many :patient_expenses, dependent: :destroy
  has_many :patient_monthly_accounts, dependent: :destroy

  validates :open_date, presence: true
end
