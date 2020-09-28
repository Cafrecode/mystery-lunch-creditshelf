# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@cafrecode.co.ke'
  layout 'mailer'
end
