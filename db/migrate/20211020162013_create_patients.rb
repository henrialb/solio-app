class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :full_name
      t.string :name
      t.date :date_of_birth
      t.integer :is_active
      t.string :citizen_no
      t.string :nif_no
      t.string :health_no
      t.string :social_security_no
      t.string :clothes_tag

      t.timestamps
    end
  end
end
