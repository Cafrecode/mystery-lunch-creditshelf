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
class Lunch < ApplicationRecord

  scope :this_month, -> (from_date = 0.days.ago.beginning_of_month) { where("lunches.created_at >= ? ", from_date) }

  ################## Validations ########################

  ################## Associations #######################

  has_many    :employee_lunches, dependent: :destroy
  has_many    :employees, through: :employee_lunches

end
