class AddDefaultValueToBalanceInPatients < ActiveRecord::Migration[7.0]
  def change
    change_column :patients, :balance, :decimal, default: 0, null: false
  end
end
