require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:two)
  end

  test "should get login" do
    get user_login_url
    assert_response :success

    assert_template layout: 'application'
    assert_select 'h1', 'Login with your Whamazone Account'
    assert_select 'form', true
    assert_select 'form input', 5
  end

  test "should login user" do
    # Login using users(:two) in the users.yml fixture
    post sessions_path, params: {login: {email: 'Test@Mail.com', password: 'test'}}
    assert_redirected_to root_path
    assert_not_empty flash[:notice]
  end

  test "should not login user" do
    # Attempt login using the wrong password
    post sessions_path, params: {login: {email: 'Test@Mail.com', password: 'wrongPassword'}}
    assert_redirected_to user_login_path
    assert_not_empty flash[:alert]

    # Attempt login using a non-existent user account
    post sessions_path, params: {login: {email: 'nonExistent@Mail.com', password: 'password'}}
    assert_redirected_to user_login_path
    assert_not_empty flash[:alert]
  end

  test "should logout user" do
    # Login user as normal
    post sessions_path, params: {login: {email: 'Test@Mail.com', password: 'test'}}
    assert_redirected_to root_path
    assert_not_empty flash[:notice]
    # Logout user
    get user_logout_path
    assert_redirected_to root_path
    assert_not_empty flash[:notice]
  end
end
