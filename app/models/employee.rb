class Employee < ApplicationRecord
  # belongs_to :user
  has_many :employee_admissions

  validates :full_name, :role, presence: true
end
