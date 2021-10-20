class CreatePatientAdmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_admissions do |t|
      t.references :patient, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
