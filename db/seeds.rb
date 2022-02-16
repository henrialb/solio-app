# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts 'Creating a lot of seeds 🌱'
puts '---------------'

# Patients
puts 'Destroying patients'
Patient.destroy_all

puts 'Creating patients'
Patient.create!(name: 'Gertrudes', full_name: 'Maria Gertrudes Silva', sex: 1, dob: Date.new(1936, 9, 16), citizen_no: '13345678', nif_no: '99999996', health_no: '11117111', social_security_no: '33333303', clothes_tag: 'MGS')
Patient.create!(name: 'Ana', full_name: 'Ana Gomes', sex: 1, dob: Date.new(1940, 5, 11), citizen_no: '12345678', nif_no: '19999999', health_no: '11411111', social_security_no: '33333323', clothes_tag: 'MGS')
Patient.create!(name: 'Alberto', full_name: 'Alberto João Jardim', sex: 2, dob: Date.new(1932, 3, 12), citizen_no: '12345668', nif_no: '99999999', health_no: '11111115', social_security_no: '33333333', clothes_tag: 'MGS')
puts 'Done creating patients'
puts '---------------'

# Patient Admissions, Files and Exits
puts 'Creating patient admissions'
patients = Patient.all
patients.each do |patient|
  PatientAdmission.create!(patient_id: patient.id, date: Faker::Date.between(from: '1997-11-17', to: Date.today))
end

puts 'Creating patient files and exits'
admissions = PatientAdmission.all
admissions.each do |admission|
  if admission.id.odd?
    file = PatientFile.create!(
      patient_admission_id: admission.id,
      open_date: admission.date,
      close_date: Faker::Date.between(from: admission.date, to: Date.today),
      note: [nil, Faker::Lorem.sentence].sample
    )
    PatientExit.create!(
      patient_admission_id: admission.id,
      date: file.close_date,
      reason: ['saiu', 'faleceu'].sample,
      location: Faker::TvShows::Simpsons.location,
      note: [nil, Faker::Lorem.sentence].sample
    )
  else
    PatientFile.create!(patient_admission_id: admission.id, open_date: admission.date)
  end
end

# Create a second admission for first patient
puts 'Adding a new admission and file for first patient'

last_admission = PatientAdmission.create!(patient_id: Patient.first.id, date: Faker::Date.between(from: PatientExit.first.date, to: Date.today))
PatientFile.create!(patient_admission_id: last_admission.id, open_date: last_admission.date)

puts 'Done creating patient admissions, files and exits'
puts '---------------'

# Patient Expenses, Receivables and Payments
puts 'Creating patient expenses, receivables and payments'

expense_descriptions = %w[Farmácia Cabeleireiro Acompanhamento Fraldas Consumíveis]

patients.each do |patient|
  patient.patient_files.each do |patient_file|
    rand(1..3).times do # receivables
      receivable_total = 0
      next_receivable = PatientReceivable.maximum(:id).to_i.next

      rand(1..4).times do # expenses
        expense = PatientExpense.create!(
          patient_file_id: patient_file.id,
          patient_id: patient.id,
          description: expense_descriptions.sample,
          amount: Faker::Commerce.price(range: 2..29.99),
          date: Faker::Date.between(from: patient_file.open_date, to: Date.today),
          note: [nil, Faker::Lorem.sentence].sample,
          patient_receivable_id: next_receivable
        )
        receivable_total += expense.amount
      end

      # Create Receivables
      expenses_receivable = PatientReceivable.new(
        patient_id: patient.id,
        patient_file_id: patient_file.id,
        amount: receivable_total,
        date: Faker::Date.between(from: patient_file.open_date,to: Date.today),
        description: 'Despesas',
        is_paid: [true, false].sample
      )
      monthly_fee_receivable = PatientReceivable.new(
        patient_id: patient.id,
        patient_file_id: patient_file.id,
        amount: patient.monthly_fee,
        date: expenses_receivable.date,
        description: 'Mensalidade',
        is_paid: expenses_receivable.is_paid
      )

      total_amount = expenses_receivable.amount + monthly_fee_receivable.amount

      if expenses_receivable.is_paid?
        # Create Payment
        payment = PatientPayment.create!(patient_id: patient.id, amount: total_amount, date: expenses_receivable.date, note: [nil, Faker::Lorem.sentence].sample)

        expenses_receivable.patient_payment_id = payment
        monthly_fee_receivable.patient_payment_id = payment
      end

      expenses_receivable.save!
      monthly_fee_receivable.save!
    end
  end
end

puts 'Done creating patient expenses, receivables and payments'
puts '---------------'

# puts 'Destroying users'
# User.destroy_all

# puts 'Creating users'
# User.create!(email: 'ana.souza@email.com', password: '123456', role: 2)
# User.create!(email: 'maria.coelho@email.com', password: '123456', role: 2)
# puts 'Done creating users'
# puts '---------------'

# puts 'Creating employees'
# Employee.create!(user_id: 1, full_name: 'Ana Maria Souza', name: 'Ana', dob: Date.new(1978, 10, 16), citizen_no: '12344668', nif_no: '19988999', health_no: '12411601', address: 'Rua Principal, 1', phone: '9182736456', email: 'ana.souza@email.com', role: 'nurse', nationality: 'portuguese')
# Employee.create!(user_id: 2, full_name: 'Maria Coelho', name: 'Maria', dob: Date.new(1985, 7, 10), citizen_no: '12355668', nif_no: '19987999', health_no: '12417501', address: 'Rua Secundária, 2', phone: '9262736456', email: 'maria.coelho@email.com', role: 'nurse', nationality: 'portuguese')
# puts 'Done creating employees'
# puts '---------------'



# puts 'Creating patient files'

# patient_admissions = PatientAdmission.all
# patient_admissions.each do |p_admission|
#   rand(1..2).times do
#     p_file = PatientFile.create!(patient_admission: p_admission, open_date: Date.new(2020, 10, 15), note: "Just chillin' killin'")
#     p_file.save!
#   end
# end

# puts 'Done creating patient files'
# puts '---------------'

# puts 'Creating patient expenses'

# patient_files = PatientFile.all

# patient_files.each do |p_file|
#   rand(1..4).times do
#     p_expense = PatientExpense.create!(patient_file: p_file, description: 'An expensive expense', amount: rand(10.0..100.9), note: 'What a note!!', date: Date.new(2021, 9, 6))
#     p_expense.save!
#   end
# end

# puts 'Done creating patient expenses'
# puts '---------------'

# puts 'Creating patient relatives'
# PatientRelative.create!(patient_id: 1, name: 'Diogo', relationship: 'son', phone: '9152934704', email: 'diogo@diogoemail.com', address: 'Avenida Principal 7', is_main: true, note: 'usually visits at sundays')
# PatientRelative.create!(patient_id: 1, name: 'Madalena', relationship: 'daughter', phone: '9152934874', email: 'mada@email.com', address: 'Avenida Principal 7', is_main: false)
# PatientRelative.create!(patient_id: 2, name: 'José António', relationship: 'husband', phone: '9152627704', address: 'Avenida dos Moradores 2', is_main: true, note: 'visits everyday')
# puts 'Done creating patient relatives'
# puts '---------------'

# puts 'Creating patient exits'

# patient_admissions = PatientAdmission.all

# patient_admissions.each do |p_admission|
#   p_exit = PatientExit.create!(patient_admission: p_admission, date: Date.new(2021, 10, 15), reason: 'escaped', location: 'Who knows 🤷‍♀️', note: 'wtf')
#   p_exit.save!
# end

# puts 'Done creating patient exits'
# puts '---------------'

# puts 'Creating patient monthly accounts'

# patient_files = PatientFile.all

# patient_files.each do |p_file|
#   p_monthly_account = PatientMonthlyAccount.create!(patient_file: p_file, month: (Date.new(2021, 9, 6)).mon, total: 666, is_paid: false)
#   p_monthly_account.save!
# end

# puts 'Done creating patient monthly accounts'
# puts '---------------'

# puts 'Creating employee admissions'
# EmployeeAdmission.create!(employee_id: 1, date: Date.new(2017, 9, 30))
# EmployeeAdmission.create!(employee_id: 2, date: Date.new(2018, 4, 22))
# puts 'Done creating employee admissions'
# puts '---------------'

# puts 'Creating employee exits'

# employee_admissions = EmployeeAdmission.all

# employee_admissions.each do |e_admission|
#   e_exit = EmployeeExit.create!(employee_admission: e_admission, date: Date.new(2021, 8, 2), note: 'Everything ok')
#   e_exit.save!
# end

# puts 'Done creating employee exits'
# puts '---------------'

# puts 'Destroying visits'
# Visit.destroy_all

# puts 'Creating visits'
# Visit.create!(patient_id: 1, date: Date.new(2021, 11, 9), time: Time.new(2021, 11, 9, 12), visitor_name: 'Mário', user_id: 1, is_video: true)
# Visit.create!(patient_id: 3, date: Date.new(2021, 11, 9), time: Time.new(2021, 11, 9, 13), visitor_name: 'Ana Margarida', user_id: 2, is_video: false, note:'will bring cake')
# puts 'Done creating visits'
# puts '---------------'

puts 'Done seeding 💪🏽'
