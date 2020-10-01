# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/employees', type: :request do
  # Employee. As you add validations to Employee, be sure to
  # adjust the attributes here as well.
  let(:employee) { Employee.create!(email: 'mex@you.com', password: 'password123', name: 'Wau Wii', status: 'active', department: 'data') }
  before(:each) { sign_in employee }

  let(:valid_attributes) do
    { name: 'Fredrick N', email: 'me@you.com', password: '1234567', password_confirmation: '1234567', department: 'data' }
  end

  let(:invalid_attributes) do
    { name: 'Fredrick', password: 'woow' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Employee.create! valid_attributes
      get employees_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      employee = Employee.create! valid_attributes
      get employee_url(employee)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_employee_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      employee = Employee.create! valid_attributes
      get edit_employee_url(employee)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Employee' do
        expect do
          post employees_url, params: { employee: valid_attributes }
        end.to change(Employee, :count).by(1)
      end

      it 'redirects to the created employee' do
        post employees_url, params: { employee: valid_attributes }
        expect(response).to redirect_to(employees_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Employee' do
        expect do
          post employees_url, params: { employee: invalid_attributes }
        end.to change(Employee, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post employees_url, params: { employee: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'Frederick Nyawaya', email: 'me@you.com', password: '1234567', password_confirmation: '1234567', department: 'data' }
      end

      it 'updates the requested employee' do
        employee = Employee.create! valid_attributes
        patch employee_url(employee), params: { employee: new_attributes }
        employee.reload
        expect(employee.name).to eq('Frederick Nyawaya')
      end

      it 'redirects to the employee' do
        employee = Employee.create! valid_attributes
        patch employee_url(employee), params: { employee: new_attributes }
        employee.reload
        expect(response).to redirect_to(employee_url(employee))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        employee = Employee.create! valid_attributes
        patch employee_url(employee), params: { employee: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested employee' do
      employee = Employee.create! valid_attributes
      delete employee_url(employee)

      employee.reload
      expect(employee.status).to eq 'deleted'
    end

    it 'redirects to the employees list' do
      employee = Employee.create! valid_attributes
      delete employee_url(employee)
      expect(response).to redirect_to(employees_url)
    end
  end
end
