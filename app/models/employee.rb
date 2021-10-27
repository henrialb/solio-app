class Employee < ApplicationRecord
  has_many :employee_admissions
  has_many :employee_exits, through: :employee_admissions

  validates :full_name, :role, presence: true
end
