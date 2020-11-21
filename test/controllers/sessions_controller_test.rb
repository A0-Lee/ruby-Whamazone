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

  test "user should login" do
    # Create a new user using sign-up form
    post users_path, params: {user: {username: 'test', name: 'Mr Test', email: 'test@mail.com', password: 'password', password_confirmation: 'password'}}
    # Login new user using login form
    post sessions_path, params: {login: {email: 'test@mail.com', password: 'password'}}
    assert_redirected_to root_path
    assert_not_empty flash[:notice]
  end

  test "user should not login" do
    # Login non-existing user using login form
    post sessions_path, params: {login: {email: 'test@mail.com', password: 'password'}}
    assert_redirected_to user_login_path
    assert_not_empty flash[:alert]
  end

  test "user should logout" do
    # Create a new user using sign-up form
    post users_path, params: {user: {username: 'test', name: 'Mr Test', email: 'test@mail.com', password: 'password', password_confirmation: 'password'}}
    # Logout user
    get user_logout_path

    assert_redirected_to root_path
    assert_not_empty flash[:notice]
  end
end
