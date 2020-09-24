# frozen_string_literal: true

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
require 'rails_helper'

RSpec.describe Lunch, type: :model do
  describe 'Associations' do
    it { should have_many(:employees) }
  end
end
