require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get user_login_url
    assert_response :success

    assert_template layout: 'application'
    assert_select 'h1', 'Login with your Whamazone Account'
    assert_select 'form', true
    assert_select 'form input', 4
  end
end
