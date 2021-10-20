class CreatePatientFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_files do |t|
      t.references :patient_admission, null: false, foreign_key: true
      t.date :open_date
      t.date :close_date
      t.string :note

      t.timestamps
    end
  end
end
