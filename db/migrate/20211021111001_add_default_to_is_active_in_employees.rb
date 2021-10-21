class AddDefaultToIsActiveInEmployees < ActiveRecord::Migration[6.1]
  def change
    change_column :employees, :is_active, :boolean, default: true
  end
end
