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
require 'rails_helper'

RSpec.describe EmployeeLunch, type: :model do
  fixtures :employees, :lunches

  subject do
    described_class.new(employee: employees(:francine), lunch: lunches(:lunch), date: "2010 05")
  end

  let(:employee_lunch) { described_class.new(employee: employees(:berry), lunch: lunches(:lunch), date: "2012 07") }

  describe 'Validations' do
    it 'should be valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'shoud not be valid with employees from the same department' do
      employee_lunch.save!
      subject.save!

      expect(subject).to_not be_valid
    end

    it { expect(subject).to_not validate_uniqueness_of(:employee_id).scoped_to(:lunch_id) }
    it { expect(subject).to_not validate_uniqueness_of(:employee_id).scoped_to(:date) }
    it { expect(subject).to validate_presence_of(:lunch_id) }

  end

  describe 'Callbacks' do
    it { expect(subject).to callback(:notify_matched_employees).after(:commit) }
    it { expect(subject).to callback(:set_date).before(:validation) }
  end

  describe 'Associations' do
    it { expect(subject).to belong_to(:lunch) }
  end
end
