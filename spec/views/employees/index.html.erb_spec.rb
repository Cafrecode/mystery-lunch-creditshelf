# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'employees/index', type: :view do
  before(:each) do
    assign(:employees, [
             Employee.create!(
               name: 'Name DS',
               department: 2,
               status: 0,
               email: 'me@you.com',
               password: 'qwerqwe'
             ),
             Employee.create!(
               name: 'Name QW',
               department: 2,
               status: 0,
               email: 'mex@you.com',
               password: 'qwerqwe'
             )
           ])
  end

  it 'renders a list of employees' do
    render
    assert_select 'tr>td', text: 'Name QW'.to_s, count: 1
    assert_select 'tr>td', text: 'Name DS'.to_s, count: 1
    assert_select 'tr>td', text: 'Marketing'.to_s, count: 2
  end
end
