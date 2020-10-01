# frozen_string_literal: true

module ApplicationHelper
  def current_user_name
    if employee_signed_in?
      current_employee.name
    else
      'Anonymous'
    end
  end

  def current_user_email
    if employee_signed_in?
      current_employee.email
    else
      'Sign In'
    end
  end
end
