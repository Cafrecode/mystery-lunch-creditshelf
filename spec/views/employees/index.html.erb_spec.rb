require 'rails_helper'

RSpec.describe "employees/index", type: :view do
  before(:each) do
    assign(:employees, [
      Employee.create!(
        name: "Name",
        department: 2,
        status: 3,
        email: 'me@you.com',
        password: 'qwerqwe'
      ),
      Employee.create!(
        name: "Name",
        department: 2,
        status: 3,
        email: 'mex@you.com',
        password: 'qwerqwe'
      )
    ])
  end

  it "renders a list of employees" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
