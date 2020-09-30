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

  ###################### Callbacks ##########################

  after_commit :execute_matching
  before_validation :cleanup_current_lunches

  ###################### Concerns ############################

  def match
    # match employees?, assuming ideal conditions. work on edge cases later
    # create lunch, date is now -- created at, whatver
    # create employee lunch
    # add both self and viable match if not nil to lunch - via employee lunch
    partner = get_mystery_match # We dont want to get two random parters! whoosh, that was close.

    if is_available && partner.present? && no_match_in_the_last_three_months(partner)
      lunch = Lunch.create!
      EmployeeLunch.create!(lunch: lunch, employee: self)
      EmployeeLunch.create!(lunch: lunch, employee: partner)
    end
  end

  def get_mystery_match
    # get unmatched employees from diff department
    viable_matches = Employee.where.not(department: department, status: :deleted)
    # Filter them based on their availability: have they been matched?
    # Missing three month check to negate viability
    viable_matches.select(&:is_available).sample
  end

  def is_available
    # Should have an active status, and no lunches already matched this months
    self.status == 'active' && (active_lunches.empty? || (active_lunches.last.present? && active_lunches.last.employees.count <= 1))
  end

  def is_compatible (employee)
    employee.department != self.department && no_match_in_the_last_three_months(employee) && self.status == 'active' && employee.status == 'active'
  end

  private

  def active_lunches # lunches this month for this Employee,if any. Take care not to create a lot of them? Only consider first one
    lunches.filter { |lunch| lunch.created_at >= 0.days.ago.beginning_of_month }
  end

  # Filter specific partner for past 3 months match
  def no_match_in_the_last_three_months (prospective)
    EmployeeLunch.previous_three_months([self.id, prospective.id]).count < 2
  end

  ############### Validation utils ###################################

  def has_full_name
    if name.gsub(/\s+/m, ' ').strip.split(' ').length < 2
      errors.add(:name, 'is not a valid name, use space separated full name')
    end
  end

  ############## Callback utils #######################################

  # run when creating employee, or status changing from deleted to active
  def execute_matching
    EmployeeMatchingJob.perform_later
  end

  def cleanup_current_lunches 
    puts 'status off#####################################: ' + self.inspect + ' ' + self.status
    if self.status == 'deleted'
      # TODO: if current had 3 partners, delete only his employee_lunch record
      # orther if paired, delete all to free the other one for a match
      # self.lunches.this_month.this_month.destroy_all
      self.employee_lunches.this_month.destroy_all
      # unless self.lunches.this_month.first.blank?
      #     if self.lunches.this_month.first.employee_lunches.count < 3
      #       self.lunches.this_month.destroy_all
      #     else 
      #       self.employee_lunches.this_month.first.destroy
      #     end
      #   end
    end
  end
end
