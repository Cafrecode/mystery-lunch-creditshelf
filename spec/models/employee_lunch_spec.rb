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
require "rails_helper"

RSpec.describe EmployeeLunch, type: :model do
  
  subject {
    described_class.new(employee: Employee.new, lunch: Lunch.new)
  }

  describe "Validations" do
    it "should be valid with valid attributes" do
      expect(subject).to be_valid
    end
  end
end
