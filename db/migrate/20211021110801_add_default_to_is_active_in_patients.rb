class AddDefaultToIsActiveInPatients < ActiveRecord::Migration[6.1]
  def change
    change_column :patients, :is_active, :integer, default: 1, null: false
  end
end
