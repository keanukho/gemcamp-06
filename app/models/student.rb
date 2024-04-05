class Student < ApplicationRecord
  validates :name, :student_serial_number, :birthdate, :phone_number, presence: true
  has_many :students
end
