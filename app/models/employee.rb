class Employee < ApplicationRecord
  belongs_to :user
  has_many :employee_admissions, dependent: :destroy

  validates :full_name, :role, presence: true
end
