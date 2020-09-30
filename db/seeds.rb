# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

employees = Employee.create([
    {name: 'Lizzy D', email: 'o.frederickn@gmail.com', password: '123456', password_confirmation: '123456', department: 'marketing'},
    {name: 'Mary FG', email: 'frederick@cafrecode.co.ke', password: '123456', password_confirmation: '123456', department: 'sales'},
    {name: 'Frank DF', email: 'frederick.nyash@gmail.com', password: '123456', password_confirmation: '123456', department: 'operations'},
    {name: 'Maureen FG', email: 'frederickno@live.com', password: '123456', password_confirmation: '123456', department: 'data'},
    {name: 'Maureen FG', email: 'o..frederickn@gmail.com', password: '123456', password_confirmation: '123456', department: 'sales', status: 'deleted'},
    {name: 'Frederick Om', email: 'frederick.nyash@gmail.com', password: '123456', password_confirmation: '123456', department: 'data'}
])

lunch = Lunch.create!(date: 1.day.ago)

el2 = EmployeeLunch.create!(employee: Employee.first, lunch: lunch, date: 1.day.ago)

el1 = EmployeeLunch.create!(employee: Employee.second, lunch: lunch, date: 1.day.ago)
