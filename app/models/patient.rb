class Patient < ApplicationRecord
  has_many :patient_admissions
  has_many :patient_relatives
  has_many :visits
  has_many :patient_files, through: :patient_admissions
  has_many :patient_exits, through: :patient_admissions

  validates :full_name, presence: true

  enum sex: { female: 1, male: 2 }
end
