# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts 'About to spread seeds 🌱'
puts '---------------'

# Patients
puts 'Destroying patients and associated records'
Patient.destroy_all

names = %w(Maria Ana Joana Isabel Catarina Rita Vitória Luísa Raquel Aurora)
surnames = %w(Ribeiro Pereira Domingues Cruz Silva Fernandes Antunes Machado Fontes Pinheiro)
mensalidades = [1590, 1640, 1670, 1790]

puts 'Creating patients'

10.times do
  all_names = [names.sample, names.sample, surnames.sample, surnames.sample]

  Patient.create!(
    name: all_names.first,
    full_name: all_names.join(' '),
    dob: Faker::Date.birthday(min_age: 73, max_age: 104),
    sex: rand(1..2),
    is_active: [true, false].sample,
    citizen_no: Faker::Number.number(digits: 8),
    nif_no: Faker::Number.number(digits: 9),
    health_no: Faker::Number.number(digits: 9),
    social_security_no: Faker::Number.number(digits: 11),
    clothes_tag: "#{all_names.first.first}#{all_names.second.first}#{all_names.last.first}",
    monthly_fee: mensalidades.sample,
    balance: Faker::Commerce.price(range: 0..10.0)
  )
end

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

admission = PatientAdmission.create!(patient_id: Patient.first.id, date: Faker::Date.between(from: PatientExit.first.date, to: Date.today))
PatientFile.create!(patient_admission_id: admission.id, open_date: admission.date)

puts 'Done creating patient admissions, files and exits'
puts '---------------'

# Patient Expenses, Receivables and Payments
puts 'Creating patient expenses, receivables and payments'

expense_descriptions = %w(Farmácia Cabeleireiro Acompanhamento Fraldas Consumíveis)

patients.each do |patient|
  patient.patient_files.each do |patient_file|
    rand(1..3).times do # receivables
      expenses = []
      receivable_total = 0

      rand(1..4).times do # expenses
        expense = PatientExpense.new(
          patient_file_id: patient_file.id,
          patient_id: patient.id,
          description: expense_descriptions.sample,
          amount: Faker::Commerce.price(range: 2..29.99),
          date: Faker::Date.between(from: patient_file.open_date, to: Date.today),
          note: [nil, Faker::Lorem.sentence].sample,
        )
        receivable_total += expense.amount

        expenses << expense
      end

      # Create Receivables
      expenses_receivable = PatientReceivable.new(
        patient_id: patient.id,
        patient_file_id: patient_file.id,
        amount: receivable_total,
        description: 'Despesas',
        is_paid: [true, false].sample,
        note: [nil, Faker::Lorem.sentence].sample
      )
      monthly_fee_receivable = PatientReceivable.new(
        patient_id: patient.id,
        patient_file_id: patient_file.id,
        amount: patient.monthly_fee,
        description: 'Mensalidade',
        is_paid: expenses_receivable.is_paid,
        note: [nil, Faker::Lorem.sentence].sample
      )

      total_amount = expenses_receivable.amount + monthly_fee_receivable.amount

      if expenses_receivable.is_paid?
        # Create Payment
        payment = PatientPayment.create!(patient_id: patient.id, amount: total_amount, date: Date.today, note: [nil, Faker::Lorem.sentence].sample)

        expenses_receivable.patient_payment_id = payment
        monthly_fee_receivable.patient_payment_id = payment
      end

      expenses_receivable.save!

      expenses.each do |expense|
        expense.patient_receivable_id = expenses_receivable.id
        expense.save!
      end

      monthly_fee_receivable.save!
    end
  end
end

puts 'Done creating patient expenses, receivables and payments'
puts '---------------'

puts 'Done seeding the database 💪'
