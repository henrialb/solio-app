# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# seeding patients
puts 'Destroying Patients'
Patient.destroy_all

puts 'Creating Patients'
# TODO: create PatientAdmission and PatienFile when Patient is created

Patient.create!(name: 'Gertrudes', full_name: 'Maria Gertrudes Silva', sex: 1, dob: Date.new(1936, 9, 16), citizen_no: '13345678', nif_no: '99999996', health_no: '11117111', social_security_no: '33333303', clothes_tag: 'MGS')
Patient.create!(name: 'Ana', full_name: 'Ana Gomes', sex: 1, dob: Date.new(1940, 5, 11), citizen_no: '12345678', nif_no: '19999999', health_no: '11411111', social_security_no: '33333323', clothes_tag: 'AG')
Patient.create!(name: 'Alberto', full_name: 'Alberto João Jardim', sex: 2, dob: Date.new(1932, 3, 12), citizen_no: '12345668', nif_no: '99999999', health_no: '11111115', social_security_no: '33333333', clothes_tag: 'AJJ')

puts 'Patients Created'
puts '-------------'


# seeding users
puts 'Destroying Users'
User.destroy_all

puts 'Creating Users'
User.create!(email: 'maria@email.com', password: '123456', role: 2)
User.create!(email: 'pcardoso@email.com', password: '123456', role: 2)
User.create!(email: 'contanca@email.com', password: '123456', role: 3)


puts 'Users Created'
puts '-------------'

# seeding employees
puts 'Destroying Employees'
Employee.destroy_all

puts 'Creating Employees'
# TODO: create EmployeeAdmission when Patient is created

Employee.create!(user_id: 1, name: 'Maria', full_name: 'Maria Madalena Jesus', dob: Date.new(1985, 6, 17), address: 'Rua Principal, 2', phone: '914538729', email: 'maria@email.com', nationality: 'portuguese', role: 'nurse', citizen_no: '13345698', nif_no: '99993396', health_no: '22117111')
Employee.create!(user_id: 2, name: 'Paula', full_name: 'Paula Cardoso', dob: Date.new(1989, 5, 12), address: 'Rua Secundária, 32', phone: '9142486029', email: 'pcardoso@email.com', nationality: 'brazilian', role: 'main nurse', citizen_no: '13341238', nif_no: '45993396', health_no: '22115611')
Employee.create!(user_id: 3, name: 'Constança', full_name: 'Constança de Mendonça', dob: Date.new(1980, 4, 4), address: 'Avenida, 7', phone: '914238729', email: 'contanca@email.com', nationality: 'portuguese', role: 'carer', citizen_no: '13322698', nif_no: '99113396', health_no: '22117971')

puts 'Employees Created'
puts '-------------'

puts 'Everything seeded 🌱'
