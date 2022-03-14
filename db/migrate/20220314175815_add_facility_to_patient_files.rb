class AddFacilityToPatientFiles < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_files, :facility, :integer
  end
end
