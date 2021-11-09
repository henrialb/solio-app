# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Destroying patient expenses'
PatientExpense.destroy_all

puts 'Destroying patient files'
PatientFile.destroy_all

puts 'Destroying patients'
Patient.destroy_all

puts 'Creating patients'
Patient.create!(name: 'Gertrudes', full_name: 'Maria Gertrudes Silva', sex: 1, dob: Date.new(1936, 9, 16), citizen_no: '13345678', nif_no: '99999996', health_no: '11117111', social_security_no: '33333303', clothes_tag: 'MGS')
Patient.create!(name: 'Ana', full_name: 'Ana Gomes', sex: 1, dob: Date.new(1940, 5, 11), citizen_no: '12345678', nif_no: '19999999', health_no: '11411111', social_security_no: '33333323', clothes_tag: 'MGS')
Patient.create!(name: 'Alberto', full_name: 'Alberto João Jardim', sex: 2, dob: Date.new(1932, 3, 12), citizen_no: '12345668', nif_no: '99999999', health_no: '11111115', social_security_no: '33333333', clothes_tag: 'MGS')
puts 'Done creating patients'
puts '---------------'

puts 'Destroying users'
User.destroy_all

puts 'Creating users'
User.create!(email: 'ana.souza@email.com', password: '123456', role: 2)
User.create!(email: 'maria.coelho@email.com', password: '123456', role: 2)
puts 'Done creating users'
puts '---------------'

puts 'Creating employees'
Employee.create!(user_id: 1, full_name: 'Ana Maria Souza', name: 'Ana', dob: Date.new(1978, 10, 16), citizen_no: '12344668', nif_no: '19988999', health_no: '12411601', address: 'Rua Principal, 1', phone: '9182736456', email: 'ana.souza@email.com', role: 'nurse', nationality: 'portuguese')
Employee.create!(user_id: 2, full_name: 'Maria Coelho', name: 'Maria', dob: Date.new(1985, 7, 10), citizen_no: '12355668', nif_no: '19987999', health_no: '12417501', address: 'Rua Secundária, 2', phone: '9262736456', email: 'maria.coelho@email.com', role: 'nurse', nationality: 'portuguese')
puts 'Done creating employees'
puts '---------------'

puts 'Creating patient admissions'
PatientAdmission.create!(patient_id: 1, date: Date.new(2020, 10, 15))
PatientAdmission.create!(patient_id: 2, date: Date.new(2019, 8, 14))
PatientAdmission.create!(patient_id: 3, date: Date.new(2019, 5, 13))
puts 'Done creating patient admissions'
puts '---------------'

puts 'Creating patient files'

patient_admissions = PatientAdmission.all

patient_admissions.each do |p_admission|
  p_file = PatientFile.create!(patient_admission: p_admission, open_date: Date.new(2020, 10, 15), note: "Just chillin' killin'")
  p_file.save!
end

puts 'Done creating patient files'
puts '---------------'

puts 'Creating patient expenses'

patient_files = PatientFile.all

patient_files.each do |p_file|
  p_expense = PatientExpense.create!(patient_file: p_file, description: 'An expensive expense', amount: 100, note: 'What a note!!', date: Date.new(2021, 9, 6))
  p_expense.save!
end

puts 'Done creating patient expenses'
puts '---------------'
