class EmployeeMailer < ApplicationMailer

    def send_welcome_email(employee)
        @employee = employee
        mail( :to => @employee.email, :subject => 'You account has been created on Mystery Lunch', :from => 'no-reply@cafrecode.co.ke' )
    end
end
