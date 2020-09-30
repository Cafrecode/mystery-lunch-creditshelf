# frozen_string_literal: true

require 'rails_helper'
require 'home_helper'

include HomeHelper
# Specs in this file have access to a helper object that includes
# the HomeHelper. For example:
#
# describe HomeHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe HomeHelper, type: :helper do

  let(:lizzy) { Employee.create!(name: 'Lizzy D', email: 'lizzy@gmail.com', password: '123456', password_confirmation: '123456', department: 'marketing') }
  let(:frank) { Employee.create!(name: 'Frank DF', email: 'frank@gmail.com', password: '123456', password_confirmation: '123456', department: 'operations') }

  describe "Get Content" do

    it "should retreive all matched employees for the current month" do
      expect(EmployeeLunch.current_partner_groups).to_not be_nil
    end
  end
end
