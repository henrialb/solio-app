class AddFieldsToPatient < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :type, :integer
    add_column :patients, :insurer_amount, :decimal
  end
end
