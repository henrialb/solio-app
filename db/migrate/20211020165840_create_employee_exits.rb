class CreateEmployeeExits < ActiveRecord::Migration[6.1]
  def change
    create_table :employee_exits do |t|
      t.references :employee_admission, null: false, foreign_key: true
      t.date :date
      t.string :note

      t.timestamps
    end
  end
end
