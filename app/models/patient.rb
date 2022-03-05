class Patient < ApplicationRecord
  has_many :patient_admissions, dependent: :destroy
  has_many :patient_expenses, dependent: :destroy
  has_many :patient_receivables, dependent: :destroy
  has_many :patient_payments, dependent: :destroy
  has_many :patient_files, through: :patient_admissions, dependent: :destroy
  has_many :patient_exits, through: :patient_admissions, dependent: :destroy
  has_many :patient_relatives, dependent: :destroy
  has_many :visits, dependent: :destroy

  validates :name, presence: true
  validates :citizen_no, :nif_no, :health_no, :social_security_no, uniqueness: true, allow_nil: true

  enum sex: [:female, :male]
  enum status: [:inactive, :active]
  enum type: [:private, :scml]
end
