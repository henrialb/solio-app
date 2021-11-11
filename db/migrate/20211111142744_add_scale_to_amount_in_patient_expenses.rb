class AddScaleToAmountInPatientExpenses < ActiveRecord::Migration[6.1]
  def change
    change_column :patient_expenses, :amount, :decimal, precision: 6 ,scale: 2
  end
end
