class CreatePatientExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_expenses do |t|
      t.references :patient_file, null: false, foreign_key: true
      t.string :description
      t.decimal :amount
      t.date :date
      t.string :note

      t.timestamps
    end
  end
end
