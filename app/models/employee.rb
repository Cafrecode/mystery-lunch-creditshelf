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
class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum status: %i[active deleted]

  # Use an enum for the various departments (might not be ideal, but should work for this)

  enum department: %i[operations sales marketing risk management finance hr development data]

  ##################### Validations #######################

  validates_presence_of :name, :department
  validates_format_of :name, with: /^[a-zA-Z\s]*$/i, multiline: true
  validate :has_full_name

  ##################### Associations ######################

  has_one_attached :avatar

  has_many  :employee_lunches
  has_many  :lunches, through: :employee_lunches

  def get_mystery_match
    # make sure self 'is available first -- test case, if not available, no need to proceed?' hmm, this might end up matching same person?
    # first check match table for content, return that, else proceed
    # get unmatched employees from diff department
    viable_matches = Employee.where.not(department: department, status: :deleted)
    # implies a 'is matched' check on employee
    # for period starting 1st of month
    # will need a model to hold the matching information
    # persist match status (return persisted match if available)
    viable_matches.select(&:is_available).sample
  end

  def is_available
    # Get any lunches created after last day of last month
    ## Lunches this months:
    # if empty,employee is available
    # if not empty, check that they have been matched with just one (self -- unless the third persion)
    active_lunches.empty? || (active_lunches.first.present? && active_lunches.first.employees.count <= 1)
    # filter only employees that are active here... toa ccount for 'deleted' employees
  end

  def match
    # match employees?, assuming ideal conditions. work on edge cases later
    # create lunch, date is now -- created at, whatver
    # create employee lunch
    # add both self and viable match if not nil to lunch - via employee lunch
    lunch = Lunch.create!

    empl_lunch1 = EmployeeLunch.create!(lunch: lunch, employee: self)
    empl_lunch2 = EmployeeLunch.create!(lunch: lunch, employee: get_mystery_match)
  end

  private

  def active_lunches # lunches this month for this Employee,if any. Take care not to create a lot of them? Only consider first one
    lunches.filter { |lunch| lunch.created_at >= 0.days.ago.beginning_of_month }
  end

  # Filter specific partner for past 3 months match

  def has_full_name
    if name.gsub(/\s+/m, ' ').strip.split(' ').length < 2
      errors.add(:name, 'is not a valid name, use space separated full name')
    end
  end
end
