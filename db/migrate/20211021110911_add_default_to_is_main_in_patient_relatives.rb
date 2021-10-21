class AddDefaultToIsMainInPatientRelatives < ActiveRecord::Migration[6.1]
  def change
    change_column :patient_relatives, :is_main, :boolean, default: false
  end
end
