# frozen_string_literal: true

class EmployeeMatchingJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # Do something later
    # get all employees and create matches for x month
    puts 'running the match making task now'
    Employee.all.map(&:match)
  end
end
