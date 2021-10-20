class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.references :user, null: false, foreign_key: true
      t.string :full_name
      t.string :name
      t.boolean :is_active
      t.string :address
      t.string :citizen_no
      t.string :nif_no
      t.string :health_no
      t.string :phone
      t.string :email
      t.string :role
      t.date :dob
      t.string :nationality

      t.timestamps
    end
  end
end
