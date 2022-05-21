# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# puts 'About to spread seeds 🌱'
# puts '---------------'

# # Patients
# puts 'Destroying patients and associated records'
# Patient.destroy_all

# puts 'Creating patients'

# patients_file = File.read(Rails.root.join('lib', 'seeds', 'patients.csv'))
# patients_csv = CSV.parse(patients_file, headers: true, encoding: 'utf-8')

# patients_csv.each do |patient|
#   Patient.create(
#     name: patient['name'],
#     full_name: patient['full_name'],
#     date_of_birth: patient['date_of_birth'],
#     covenant: patient['covenant'].to_i,
#     sex: patient['sex'].to_i,
#     status: patient['status'].to_i,
#     citizen_num: patient['citizen_num'],
#     nif_num: patient['nif_num'],
#     health_num: patient['health_num'],
#     social_security_num: patient['social_security_num'],
#     clothes_tag: patient['clothes_tag'],
#     monthly_fee: patient['monthly_fee'],
#     balance: patient['balance']
#   )
# end

# puts 'Done creating patients'
# puts '---------------'

# # Patient Admissions, Files and Exits
# puts 'Creating patient admissions'
# patient_admissions_file = File.read(Rails.root.join('lib', 'seeds', 'patient_admissions.csv'))

# CSV.parse(patient_admissions_file, headers: true, encoding: 'utf-8') do |admission|
#   PatientAdmission.create!(
#     patient_id: admission['patient_id'],
#     date: admission['date']
#   )
# end

# puts 'Creating patient files and exits'

# patient_files_file = File.read(Rails.root.join('lib', 'seeds', 'patient_files.csv'))

# CSV.parse(patient_files_file, headers: true, encoding: 'utf-8') do |file|
#   PatientFile.create!(
#     patient_admission_id: file['patient_admission_id'],
#     facility: file['facility'],
#     open_date: file['open_date'],
#     close_date: file['close_date'],
#     note: file['note']
#   )
# end

# patient_exits_file = File.read(Rails.root.join('lib', 'seeds', 'patient_exits.csv'))

# CSV.parse(patient_exits_file, headers: true, encoding: 'utf-8') do |exit|
#   PatientExit.create!(
#     patient_admission_id: exit['patient_admission_id'],
#     date: exit['date'],
#     reason: exit['reason'],
#     location: exit['location'],
#     note: exit['note']
#   )
# end

# puts 'Done creating patient admissions, files and exits'
# puts '---------------'

# puts 'Done seeding the database 💪'


# ------------------ FAKE DATA SEEDS -----------------

puts 'About to spread seeds 🌱'
puts '---------------'

# Patients
puts 'Destroying patients and associated records'
Patient.destroy_all

names = %w(Maria Ana Joana Isabel Catarina Rita Vitória Luísa Raquel Aurora)
surnames = %w(Ribeiro Pereira Domingues Cruz Silva Fernandes Antunes Machado Fontes Pinheiro)
mensalidades = [1590, 1640, 1670, 1790]

puts 'Creating patients'

11.times do
  all_names = [names.sample, names.sample, surnames.sample, surnames.sample]

  Patient.create!(
    name: all_names.first,
    full_name: all_names.join(' '),
    date_of_birth: Faker::Date.birthday(min_age: 73, max_age: 104),
    covenant: [:personal, :scml].sample,
    sex: [:female, :male].sample,
    status: [:active, :inactive].sample,
    citizen_num: Faker::Number.number(digits: 8),
    nif_num: Faker::Number.number(digits: 9),
    health_num: Faker::Number.number(digits: 9),
    social_security_num: Faker::Number.number(digits: 11),
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
  facility = [:'36', :'21'].sample

  if admission.id.odd?
    file = PatientFile.create!(
      patient_admission_id: admission.id,
      facility: facility,
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
    PatientFile.create!(patient_admission_id: admission.id, facility: facility, open_date: admission.date)
  end
end

# Create a second admission for first patient
puts 'Adding a new admission and file for first patient'

admission = PatientAdmission.create!(patient_id: Patient.first.id, date: Faker::Date.between(from: PatientExit.first.date, to: Date.today))

PatientFile.create!(patient_admission_id: admission.id, open_date: admission.date, facility: [:'36', :'21'].sample)

puts 'Done creating patient admissions, files and exits'
puts '---------------'

# Patient Expenses, Receivables and Payments
puts 'Creating patient expenses, receivables and payments'

expense_descriptions = %w(Farmácia Cabeleireiro Acompanhamento Fraldas Consumíveis)

patients.each do |patient|
  patient.patient_files.each do |patient_file|
    rand(0..4).times do # expenses without receivable
      PatientExpense.create(
        patient_file_id: patient_file.id,
        patient_id: patient.id,
        description: expense_descriptions.sample,
        amount: Faker::Commerce.price(range: 2..29.99),
        date: Faker::Date.between(from: patient_file.open_date, to: Date.today),
        note: [nil, Faker::Lorem.sentence].sample,
      )
    end

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
        accountable: :personal,
        source: :expenses,
        status: [:unpaid, :paid].sample,
        note: [nil, Faker::Lorem.sentence].sample
      )

      monthly_fee_receivable = PatientReceivable.new(
        patient_id: patient.id,
        patient_file_id: patient_file.id,
        amount: patient.monthly_fee,
        description: 'Mensalidade',
        accountable: patient.scml? ? :scml : :personal,
        source: :monthly_fee,
        status: expenses_receivable.status,
        note: [nil, Faker::Lorem.sentence].sample
      )

      total_amount = expenses_receivable.amount + monthly_fee_receivable.amount

      if expenses_receivable.paid?
        # Create Payment
        payment = PatientPayment.create!(
          patient_id: patient.id,
          amount: total_amount,
          date: Date.today,
          method: rand(0..4),
          accountable: patient.scml? ? :scml : :personal,
          note: [nil, Faker::Lorem.sentence].sample
        )

        expenses_receivable.patient_payment_id = payment.id
        monthly_fee_receivable.patient_payment_id = payment.id
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
