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

    validates_uniqueness_of  :employee_id, scope: :lunch_id 

    ############## Associations ##############################

    belongs_to  :employee
    belongs_to  :lunch

end
