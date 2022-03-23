class PatientAdmissionValidator < ActiveModel::Validator
  def validate(record)
    patient_id = record.patient_id
    patient_admissions = PatientAdmission.where(patient_id: patient_id)
    patient_admissions.each do |admission|
      if admission.patient_exit == nil
        record.errors.add(
          :patient_admission,
          "Este utente tem uma admissão sem saída. Não é possível criar uma nova admissão."
        )
        break
      end
    end
  end
end
