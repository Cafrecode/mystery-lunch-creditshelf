class EmployeeMatchingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # get all employees and create matches for x month
    puts 'running the match making task now'
    res = Employee.all.map(&:match)
    res.inspect
  end
end
