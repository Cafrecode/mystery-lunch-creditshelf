# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'employees/edit', type: :view do
  before(:each) do
    @employee = assign(:employee, Employee.create!(
                                    name: 'MyString WD',
                                    department: 1,
                                    status: 1,
                                    email: 'me@you.com',
                                    password: 'qwerqwe'
                                  ))
  end

  it 'renders the edit employee form' do
    render

    assert_select 'form[action=?][method=?]', employee_path(@employee), 'post' do
      assert_select 'input[name=?]', 'employee[name]'

      assert_select 'select[name=?]', 'employee[department]'

      assert_select 'select[name=?]', 'employee[status]'
    end
  end
end
