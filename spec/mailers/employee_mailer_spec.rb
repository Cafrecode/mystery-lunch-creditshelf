# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeeMailer, type: :mailer do

  fixtures  :employees
  
  describe "send welcome email" do

    let(:mail) { EmployeeMailer.send_welcome_email(employees(:francine)) }

    it "renders the headers" do
      expect(mail.subject).to eq("You account has been created on Mystery Lunch")
      expect(mail.to).to eq(["lizzyk@gmail.com"])
      expect(mail.from).to eq(["no-reply@cafrecode.co.ke"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include("Dear Lizzy DD")
    end
  end

end
