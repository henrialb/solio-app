class Visit < ApplicationRecord
  belongs_to :patient
  belongs_to :user

  validates :patient_id, :date, :time, presence: true
end
