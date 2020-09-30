# frozen_string_literal: true

module HomeHelper

  def current_partner_groups
    EmployeeLunch.this_month.group_by(&:lunch)
  end

  def previous_partner_groups
    EmployeeLunch.previous_months.group_by(&:lunch)
  end
  
end
