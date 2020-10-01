# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeeMatchingJob, type: :job do
  
  subject(:job) { described_class.perform_later }

  it 'is in urgent queue' do
    expect(EmployeeMatchingJob.new.queue_name).to eq('default')
  end
  
end
