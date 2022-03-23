class PatientFileValidator < ActiveModel::Validator
  def validate(record)
    patient_admission_id = record.patient_admission_id
    close_dates = PatientFile.where(patient_admission_id: patient_admission_id).pluck(:close_date)
    if close_dates.include?(nil)
      record.errors.add(
        :patient_file,
        "Este utente tem um processo aberto. Não é possível criar um novo processo."
      )
    end
  end
end
