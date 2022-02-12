class Visit < ApplicationRecord
  belongs_to :patient
  belongs_to :user

  validates :date, :time, presence: true
end
