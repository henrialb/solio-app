class RenameIsActiveToStatusInPatients < ActiveRecord::Migration[7.0]
  def change
    rename_column :patients, :is_active, :status
  end
end
