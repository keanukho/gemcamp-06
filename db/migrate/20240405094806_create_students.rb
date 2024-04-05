class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :student_serial_number
      t.date :birthdate
      t.string :phone_number

      t.timestamps
    end
  end
end
