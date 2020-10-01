# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'employees/new', type: :view do
  before(:each) do
    assign(:employee, Employee.new(
                        name: 'MyString',
                        department: 1,
                        status: 1
                      ))
  end

  it 'renders new employee form' do
    render

    assert_select 'form[action=?][method=?]', employees_path, 'post' do
      assert_select 'input[name=?]', 'employee[name]'

      assert_select 'select[name=?]', 'employee[department]'
    end
  end
end
