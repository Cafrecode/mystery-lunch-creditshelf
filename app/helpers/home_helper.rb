# frozen_string_literal: true

module HomeHelper

    def current_partners
        EmployeeLunch.all.group_by(&:lunch)
    end

end
