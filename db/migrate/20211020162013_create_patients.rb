class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :full_name
      t.string :name
      t.date :date_of_birth
      t.integer :is_active
      t.string :citizen_num
      t.string :nif_num
      t.string :health_num
      t.string :social_security_num
      t.string :clothes_tag

      t.timestamps
    end
  end
end
