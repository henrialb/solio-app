class CreatePatientPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_payments do |t|
      t.references :patient, foreign_key: true
      t.date :date
      t.decimal :amount
      t.string :note

      t.timestamps
    end
  end
end
