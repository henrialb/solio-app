class ChangePatients < ActiveRecord::Migration[6.1]
  def change
    change_column :patients, :monthly_fee, :decimal
    change_column :patients, :balance, :decimal
  end
end
