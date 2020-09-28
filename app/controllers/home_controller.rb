# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    # probably not the best place for this, but temporary
    # EmployeeMatchingJob.set(wait_until: 0.days.from_now.end_of_month + 1.second).perform_later
    EmployeeMatchingJob.perform_later
  end
end
