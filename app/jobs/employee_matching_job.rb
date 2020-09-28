class EmployeeMatchingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # get all employees and create matches for x month
  end
end
