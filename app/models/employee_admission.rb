class EmployeeAdmission < ApplicationRecord
  belongs_to :employee
  has_one :employee_exit

  validates :date, presence: true
end
