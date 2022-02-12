class Employee < ApplicationRecord
  belongs_to :user
  has_many :employee_admissions, dependent: :destroy
  has_many :employee_exits, through: :employee_admissions

  validates :name, :role, presence: true
end
