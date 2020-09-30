# frozen_string_literal: true

# == Schema Information
#
# Table name: employee_lunches
#
#  id          :bigint           not null, primary key
#  date        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :bigint
#  lunch_id    :bigint
#
class EmployeeLunch < ApplicationRecord
  
  scope :this_month, ->(from_date = 0.days.ago.beginning_of_month) { where('created_at >= ? ', from_date) }
  scope :previous_months, ->(before_date = 0.days.ago.beginning_of_month) { where('created_at < ?', before_date) }

  scope :previous_three_months, ->(employee_ids, from_date = 3.months.ago.beginning_of_month, to_date = 0.days.ago.beginning_of_month ) { where("employee_id IN (?) AND created_at >= ? AND created_at < ?", employee_ids, from_date, to_date)}

  ############### Validations #############################

  validates_uniqueness_of :employee_id, scope: :lunch_id
  validates_uniqueness_of :employee_id, scope: :date
  validates_presence_of :employee_id, :lunch_id
  validate :different_department

  ############## Associations ##############################

  belongs_to :employee
  belongs_to :lunch

  ############# Callbacks ##################################
  # After saving, send email to relevant employees notifying of their being matches
  after_save :notify_matched_employees
  before_validation :set_date

  private

  # Useful to validate unique lunches per month for employee
  def set_date
    self.date = Time.now.strftime('%Y %m')
  end

  def notify_matched_employees
    EmployeeMailer.send_request(lunch.employees) unless lunch.employees.count < 2
  end

  # Enforce no two employees can be saved if from the same department (the logic to find matches can be circumveneted and result in matching same dept)
  def different_department
    unless lunch.blank?
      if lunch.employees.where(department: employee.department).count > 1
        errors.add(:employee, 'is not valid, they need to be from different depeartments')
      end
    end
  end
end
