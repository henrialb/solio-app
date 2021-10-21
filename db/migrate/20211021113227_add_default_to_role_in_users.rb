class AddDefaultToRoleInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :role, :integer, default: 4
  end
end
