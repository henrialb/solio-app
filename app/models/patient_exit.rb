class PatientExit < ApplicationRecord
  belongs_to :patient_admission
  belongs_to :patient
end
