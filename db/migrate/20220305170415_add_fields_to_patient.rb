class AddFieldsToPatient < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :covenant, :integer, default: 0, null: false
  end
end
