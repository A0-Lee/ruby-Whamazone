require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get form" do
    get contacts_form_url

    assert_response :success
    assert_template layout: 'application'

    assert_select 'h1', 'Need Customer Support?'
    assert_select 'p', 'We have it available all-day everyday 24/7!*'

  end

  test "should post request form" do
    #post request_form_url, params:
    #{name: "John Smith", email: "johnsmith@email.com", telephone: "0123 567891", message: "test"}
    post request_form_url, params: {form: {name: 'John Smith', email: 'johnsmith@email.com', telephone: '0123 567891', message: 'test message'}}

    assert_response :redirect

    assert_not_empty flash[:notice]
  end

end
