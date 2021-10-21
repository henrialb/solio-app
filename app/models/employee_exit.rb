class EmployeeExit < ApplicationRecord
  belongs_to :employee_admission

  validates :date, presence: true
end
