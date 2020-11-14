require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
  test "should return contact email" do
    mail = ContactMailer.contact_form_email("John Smith", "johnsmith@email.com", "0123 4567891", @message = "I would like some assistance with my purchase order id #123.")
    assert_equal ['customersupport@whamazone.com'], mail.to
    assert_equal ['form-handler@whamazone.com'], mail.from
  end
end
