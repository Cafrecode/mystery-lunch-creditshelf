class EmployeeMailer < ApplicationMailer
  def send_welcome_email(employee)
    @employee = employee
    mail(:to => @employee.email, :subject => "You account has been created on Mystery Lunch", :from => "no-reply@cafrecode.co.ke")
  end

  def self.send_request(employees)
    @employees = employees

    @employees.each do |employee|
      send_match_notification(employee, @employees).deliver
    end
  end

  def send_match_notification(employee, employees)
    @employees = employees
    @employee = employee
    mail(to: employee.email, subject: "You have been matched!")
  end
end
