# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Destroying patients'
Patient.destroy_all

puts 'Creating patients'
Patient.create!(name: 'Gertrudes', full_name: 'Maria Gertrudes Silva', sex: 1, dob: Date.new(1936, 9, 16), citizen_no: '13345678', nif_no: '99999996', health_no: '11117111', social_security_no: '33333303', clothes_tag: 'MGS')
Patient.create!(name: 'Ana', full_name: 'Ana Gomes', sex: 1, dob: Date.new(1940, 5, 11), citizen_no: '12345678', nif_no: '19999999', health_no: '11411111', social_security_no: '33333323', clothes_tag: 'MGS')
Patient.create!(name: 'Alberto', full_name: 'Alberto João Jardim', sex: 2, dob: Date.new(1932, 3, 12), citizen_no: '12345668', nif_no: '99999999', health_no: '11111115', social_security_no: '33333333', clothes_tag: 'MGS')
puts 'Done!'
