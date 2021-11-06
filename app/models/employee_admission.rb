class EmployeeAdmission < ApplicationRecord
  belongs_to :employee
  has_many :patient_files, dependent: :destroy

  validates :date, presence: true
end
