# frozen_string_literal: true

module HomeHelper

    def current_partner_groups
        EmployeeLunch.all.group_by(&:lunch)
    end

end
