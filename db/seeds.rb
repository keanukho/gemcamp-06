# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# #Create 10 fake users
#  100.times do
#    User.create!(
#      name: Faker::Name.name,
#      email: Faker::Internet.email,
#      password: Faker::Internet.password
#    #bday
#    #phone number
#    #student number
#   )
# end

# Create 5 fake posts
100.times do
  Post.create!(
    title: Faker::Lorem.words(number: 3).join(' '), # Generates a title with only letters
    content: Faker::Lorem.paragraphs(number: 3).join('\n\n') # Generates content with only letters
  )
end

def generate_phone_number
  Faker::PhoneNumber.phone_number
end

# Generate student data and seed the database
30.times do
  name = Faker::Name.name
  student_serial_number = Faker::Alphanumeric.alpha(number: 6).upcase
  birthdate = Faker::Date.birthday(min_age: 18, max_age: 30)
  phone_number = generate_phone_number

  student = Student.new(
    name: name,
    student_serial_number: student_serial_number,
    birthdate: birthdate,
    phone_number: phone_number
  )

  # Validate uniqueness of student serial number
  next unless Student.find_by(student_serial_number: student_serial_number).nil?

  # Validate uniqueness of name
  next unless Student.find_by(name: name).nil?

  # Save the student
  student.save
end

