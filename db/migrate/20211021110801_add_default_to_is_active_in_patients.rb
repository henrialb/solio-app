class AddDefaultToIsActiveInPatients < ActiveRecord::Migration[6.1]
  def change
    change_column :patients, :is_active, :boolean, default: true
  end
end
