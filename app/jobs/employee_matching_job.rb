# frozen_string_literal: true

class EmployeeMatchingJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # Do something later
    # get all employees and create matches for x month
    puts 'running the match making task now'
    res = Employee.all.map(&:match)
    puts 'matching result: ' + res.inspect
  end
end
