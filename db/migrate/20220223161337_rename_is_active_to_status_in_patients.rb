class RenameIsActiveToStatusInPatients < ActiveRecord::Migration[7.0]
  def change
    change_column :patients, :is_active, :integer
    rename_column :patients, :is_active, :status
  end
end
