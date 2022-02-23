class AddMethodToPatientPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_payments, :method, :integer
  end
end
