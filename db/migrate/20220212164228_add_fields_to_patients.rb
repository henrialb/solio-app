class AddFieldsToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :monthly_fee, :float, precision: 2
    add_column :patients, :balance, :float, precision: 2
  end
end
