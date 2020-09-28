# frozen_string_literal: true

# == Schema Information
#
# Table name: employee_lunches
#
#  id          :bigint           not null, primary key
#  date        :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :bigint
#  lunch_id    :bigint
#
class EmployeeLunch < ApplicationRecord
  ############### Validations #############################

  validates_uniqueness_of :employee_id, scope: :lunch_id
  validate :different_department

  ############## Associations ##############################

  belongs_to :employee
  belongs_to :lunch

  private

  # Enforce no two employees can be saved if from the same department (the logic to find matches can be circumveneted and result in matching same dept)
  def different_department
    if self.lunch.employees.where(department: self.employee.department).count > 1
      errors.add(:employee, "is not valid, they need to be from different depeartments")
    end
  end
end