# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "Example User",
             email: "example@example.com",
             password:              "foobar311", 
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password)
end

countries = [
  ["Uganda", "UG", 256],
  ["Kenya", "KE", 254],
  ["Tanzania", "TZ", 255],
  ["Rwanda", "RW", 256],
  ["Burundi", "BU", 257]]


countries.each do |country|
  name = country[0]
  c_code = country[1]
  telephone_code = country[2]
  Country.create!(name: name,
                  c_code: c_code,
                  telephone_code: telephone_code
                  )
end