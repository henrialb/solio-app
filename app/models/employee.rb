class Employee < ApplicationRecord
  # belongs_to :user
  has_one :user
  has_many :employee_admissions
  has_many :employee_exits, through: :employee_admissions

  validates :full_name, :role, presence: true
end
