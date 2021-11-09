class EmployeeAdmission < ApplicationRecord
  belongs_to :employee
  has_many :patient_files, dependent: :destroy
  has_one :patient_exits, dependent: :destroy

  validates :date, presence: true
end
