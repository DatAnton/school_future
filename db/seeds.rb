# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  Form.create(name: "Undefined_Common")
  Form.create(name: "11A")
  Form.create(name: "11B")
  User.create(first_name: "Anton", last_name: "Datsenko", user_type: "admin", email: "tom.dacenko@gmail.com", password: "tom01tom02", password_confirmation: "tom01tom02", form_id: 2)
  User.create(first_name: "Viktor", last_name: "Kremen", user_type: "teacher", form_id: 1, email: "vikkrem@gmail.com", password: "123000", password_confirmation: "123000")
  User.create(first_name: "Anna", last_name: "Britan", user_type: "teacher", form_id: 2, email: "annBr@gmail.com", password: "123000", password_confirmation: "123000")
  User.create(first_name: "Dima", last_name: "Lyashenko", user_type: "student", form_id: 2, email: "dimLyashen@gmail.com", password: "123000", password_confirmation: "123000")
  Subject.create(name: "Math")
  Lesson.create(number: 1, day: 1, subject_id: 1, form_id: 2, user_id: 3)
  Subject.create(name: "Biology")
  Lesson.create(number: 3, day: 1, subject_id: 2, form_id: 2, user_id: 4)
  Lesson.create(number: 1, day: 2, subject_id: 1, form_id: 2, user_id: 3)
  Lesson.create(number: 2, day: 1, subject_id: 1, form_id: 2, user_id: 3)
  Lesson.create(number: 1, day: 4, subject_id: 2, form_id: 2, user_id: 4)
