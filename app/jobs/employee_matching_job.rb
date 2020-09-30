# frozen_string_literal: true

class EmployeeMatchingJob < ApplicationJob
  queue_as :default

  def perform(*_args)

    puts 'running the match making task now'
    # Math the employees as is for this month
    Employee.all.map(&:match)

    unmatched = Employee.all.filter { |em| em.is_available }

    puts 'unmatched eh *****************************************************!' + unmatched.inspect

    if unmatched.count == 1 # Just check for one, we can possibly have more than one surely
      match_odd_employee(unmatched.first)
      puts 'unmatched eh!' + unmatched.first.inspect
    end
    # Check for unmatched employes (should be one if we had an odd number)
    # Get a pair to match with, all different departments
    # Match! -- this add to pair func should be on employee concern/model to allow for new employee to added to group

  end

  def match_odd_employee (employee)

    # Get all lunches this month
    lunches = Lunch.this_month

    # Get employees in each lunch

    lunches.each do | lunch |
    # Check compatibility with all employees in lunch - department, last three months
      match = false
      lunch.employees.each do | prospect |
        match = prospect.is_compatible(employee) && lunch.employees.count < 3 # To avoid 4 people groups
      end

      if match
        # If compatibility is found, match and done
        EmployeeLunch.create!(lunch: lunch, employee: employee)
        break
      end
    end
    # Else, unknown outcome, no match, no lunch for you :( We might deal with this but rules are rules
  end
end
