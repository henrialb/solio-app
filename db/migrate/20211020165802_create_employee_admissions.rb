class CreateEmployeeAdmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :employee_admissions do |t|
      t.references :employee, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
