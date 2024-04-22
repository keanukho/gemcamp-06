
10.times do
  User.create(email: Faker::Internet.email, password: '123456')
end

100.times do
  Post.create!(
    title: Faker::Lorem.words(number: 3).join(' '), # Generates a title with only letters
    content: Faker::Lorem.paragraphs(number: 3).join('\n\n'), # Generates content with only letters
    user_id: User.pluck(:id).sample # Assign a random user_id to the post
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
  4.times do
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
end


categories = []

30.times do
  categories << { name: Faker::Educator.subject }
end

categories.each do |category|
  Category.create(category)
end








