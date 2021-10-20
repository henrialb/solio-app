class CreatePatientExits < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_exits do |t|
      t.references :patient_admission, null: false, foreign_key: true
      t.date :date
      t.string :reason
      t.string :location
      t.string :note

      t.timestamps
    end
  end
end
