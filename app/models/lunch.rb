# == Schema Information
#
# Table name: lunches
#
#  id         :bigint           not null, primary key
#  date       :datetime
#  location   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Lunch < ApplicationRecord

    ################## Validations ########################

    ################## Associations #######################

    has_many    :employee_lunches
    has_many    :employees, through: :employee_lunches
end
