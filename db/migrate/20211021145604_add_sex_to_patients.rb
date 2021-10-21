class AddSexToPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :sex, :integer
  end
end
