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
require 'rails_helper'

RSpec.describe EmployeeLunch, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
