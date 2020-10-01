# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

employees = Employee.create([
                              { name: 'Mystery Lunch', email: 'mystery@lunch.com', password: '123456', password_confirmation: '123456', department: 'marketing' },
                              { name: 'Frederick Om', email: 'o.frederickn@gmail.com', password: '123456', password_confirmation: '123456', department: 'sales' },
                            ])

# Create 17 to make an odd 19

17.times do |index|
    employee = Employee.new(
                              name: Faker::Name.name, 
                              email: Faker::Internet.email, 
                              password: '123456', 
                              password_confirmation: '123456', 
                              department: Employee.departments.map {|k, v| k }.sample)
    employee.avatar.attach(io: File.open(Rails.root.join('db').to_s + '/faces/' + (index+1).to_s + '.jpg'), filename: 'avatar.jpg', content_type: 'image/jpeg')
    employee.save!
  end

# Clear the lucnhes that get assigned to new employees when created
['lunches', 'employee_lunches'].each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
end
