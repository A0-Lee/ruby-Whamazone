require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get signup" do
    get user_signup_url
    assert_response :success

    # There's no need to test every HTML tag element as if the first few are valid, then this implies the rest are too
    # This is because all the text are localised strings from configs/locales/en.yml
    assert_template layout: 'application'
    assert_select 'h1', 'Sign-up today as a Whamazone customer!'
    assert_select 'p', 'We offer several benefits towards being an existing customer:'
    # Check if form exists
    assert_select 'form', true
    # Note that the submit button and the hidden utf8 name counts as input fields
    assert_select 'form input', 7
  end

  test "should get account" do
    # Sign up as a new user
    post users_path, params: {user: {username: 'actualJohnSmith', name: 'John Smith', email: 'realJohnSmith@mail.com', password: 'password', password_confirmation: 'password'}}

    # User should be automatically logged in upon valid sign-up
    get user_account_url
    assert_response :success
    assert_not_empty flash[:notice]

    assert_template layout: 'application'
    assert_select 'h1', 'My Whamazone Account'
    assert_select 'p', 'Your account details:'
  end

  test "should not get account" do
    # user should be redirected to root_path if not logged in
    get user_account_url
    assert_redirected_to root_path
  end

  test "should signup user" do
    post users_path, params: {user: {username: 'actualJohnSmith', name: 'John Smith', email: 'realJohnSmith@mail.com', password: 'password', password_confirmation: 'password'}}
    assert_redirected_to root_path
    assert_not_empty flash[:notice]
  end

  test "should not signup user" do
    post users_path, params: {user: {username: 'actualJohnSmith', name: 'John Smith', email: 'realJohnSmith@mail.com', password: 'password', password_confirmation: 'wrongPassword'}}
    assert_redirected_to user_signup_path
    assert_not_empty flash[:alert]
  end

end
