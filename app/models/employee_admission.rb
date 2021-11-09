class EmployeeAdmission < ApplicationRecord
  belongs_to :employee
  has_one :employee_exit, dependent: :destroy

  validates :date, presence: true
end
