# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show edit update destroy]
  before_action :authenticate_employee!

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show; end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit; end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    ### Generate aa random 6 char password for the user which is delivered via email
    password = Devise.friendly_token.first(6)

    @employee.password = password
    @employee.password_confirmation = password

    respond_to do |format|
      if @employee.save

        EmployeeMailer.send_welcome_email(@employee).deliver # Maybe do it async?

        format.html { redirect_to employees_url, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.status = 'deleted'
    @employee.save!
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.require(:employee).permit(:name, :department, :status, :email, :avatar)
  end
end
