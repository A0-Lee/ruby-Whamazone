class ApplicationMailer < ActionMailer::Base
  default to: "customersupport@whamazone.com", from: "form-handler@whamazone.com"
  layout 'mailer'
end
