class EmployeeExit < ApplicationRecord
  belongs_to :employee_admission
  belongs_to :employee

  validates :date, presence: true
end
