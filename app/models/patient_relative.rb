class PatientRelative < ApplicationRecord
  belongs_to :patient

  validates :name, presence: true
end
