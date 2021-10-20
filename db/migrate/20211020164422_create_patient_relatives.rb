class CreatePatientRelatives < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_relatives do |t|
      t.references :patient, null: false, foreign_key: true
      t.string :name
      t.string :relationship
      t.string :phone
      t.string :email
      t.string :address
      t.boolean :is_main
      t.string :note

      t.timestamps
    end
  end
end
