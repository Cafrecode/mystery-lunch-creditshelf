# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'employees/show', type: :view do
  before(:each) do
    @employee = assign(:employee, Employee.create!(
                                    name: 'Name Wau',
                                    department: 2,
                                    status: 0,
                                    email: 'me@you.com',
                                    password: 'qwerqwe'
                                  ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
