# frozen_string_literal: true

# == Schema Information
#
# Table name: employees
#
#  id                     :bigint           not null, primary key
#  department             :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  status                 :integer          default("active")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_employees_on_email                 (email) UNIQUE
#  index_employees_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe Employee, type: :model do

  let(:lizzy) { Employee.create!(name: 'Lizzy D', email: 'lizzy@gmail.com', password: '123456', password_confirmation: '123456', department: 'marketing') }
  let(:frank) { Employee.create!(name: 'Frank DF', email: 'frank@gmail.com', password: '123456', password_confirmation: '123456', department: 'operations') }
  let(:mary) { Employee.create!(name: 'Mary FG', email: 'mary@gmail.com', password: '123456', password_confirmation: '123456', department: 'sales') }
  let(:maureen) { Employee.create!(name: 'Maureen FG', email: 'maryw@gmail.com', password: '123456', password_confirmation: '123456', department: 'data') }
  let(:eva) { Employee.create!(name: 'Maureen FG', email: 'maryw@gmail.com', password: '123456', password_confirmation: '123456', department: 'sales', status: 'deleted') }

  subject do
    described_class.new(name: 'Frederick Om', email: 'frederick@gmail.com', password: '123456', password_confirmation: '123456', department: 'data')
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a valid name (name with numbers)' do
      subject.name = '123Fred'
      expect(subject).to_not be_valid
    end

    it 'is not valid without a valid name (single name)' do
      subject.name = 'Fred'
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should have_many(:lunches) }
  end

  describe 'Match' do

    it 'has a match from a different department' do
      # hmm, strange that i have to call save explicitly
      lizzy.save!
      frank.save!
      mary.save!
      expect(subject.get_mystery_match).to_not be_nil
      expect(subject.get_mystery_match.department).to_not eq(subject.department)
    end

    it 'does not have a match from any other department' do
      maureen.save!
      expect(subject.get_mystery_match).to be_nil
    end

    it 'cannot match a deleted user' do
      eva.save!
      expect(subject.get_mystery_match).to be_nil
    end
  end

  describe "Availability" do

    it "is not available if already has a match with another employee" do
      # create a lunch (the matching will be moved to the model)
      lunch = Lunch.create!(date: 1.day.ago)
      lunch.save!

      # Pair up with one employee
      el2 = EmployeeLunch.create!(employee: lizzy, lunch: lunch, date: 1.day.ago)
      el2.save!

      el1 = EmployeeLunch.create!(employee: subject, lunch: lunch, date: 1.day.ago)
      el1.save!

      expect(subject.is_available).to eq false
    end

    it "is available if the last match(with employee x) was over 3 months ago" do # refine this spec
      lunch = Lunch.create!(date: 1.day.ago, created_at: 3.months.ago)
      lunch.save!

      # Pair up with one employee
      el2 = EmployeeLunch.create!(employee: lizzy, lunch: lunch, date: 1.day.ago)
      el2.save!

      el1 = EmployeeLunch.create!(employee: subject, lunch: lunch, date: 1.day.ago)
      el1.save!

      expect(subject.is_available).to eq true
    end

    it "can match a viable employee" do 
      lizzy.save!

      subject.match
      expect(subject.is_available).to eq false
    end
  end
end
