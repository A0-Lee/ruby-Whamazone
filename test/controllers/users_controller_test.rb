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
    # Note that the submit button and the hidden utf8 name counts as input fields, as well as the search bar in header
    assert_select 'form input', 8
  end

  test "should edit account details" do
    # Sign up as a new user
    post users_path, params: {user: {username: 'test', name: 'tester', email: 'tester@mail.com', password: 'password', password_confirmation: 'password'}}
    # Get new user in session as local user
    @user = User.find(session[:user_id])
    # Edit details on account edit form
    post users_path(@user), params: {user: {username: 'different', name: 'tester', email: 'different@mail.com', password: 'password', password_confirmation: 'password'}}
    assert_redirected_to root_path
    assert_not_empty flash[:notice]
    # Check if a user with the username 'different' and email 'different@mail.com' now exists in the database
    assert_equal(true, !!User.find_by(username: 'different', email: 'different@mail.com'))
  end

  test "should not edit account details" do
    # Create new existing user account and logout
    post users_path, params: {user: {username: 'exists', name: 'existing', email: 'exists@mail.com', password: 'password', password_confirmation: 'password'}}
    get user_logout_path
    assert_redirected_to root_path
    # Create another user account
    post users_path, params: {user: {username: 'test', name: 'tester', email: 'tester@mail.com', password: 'password', password_confirmation: 'password'}}
    get user_edit_path
    # Try to edit details with existing username
    post users_path(@user), params: {user: {username: 'different', name: 'tester', email: 'tester@mail.com', password: 'password', password_confirmation: 'password'}}
    assert_redirected_to user_signup_path
    assert_not_empty flash[:alert]
    # Check if the failed user edit parameters doesn't exist in the datbase
    assert_equal(false, !!User.find_by(username: 'exists', email: 'tester@mail.com'))
  end

  test "should get account edit" do
    # Sign up as a new user
    post users_path, params: {user: {username: 'test', name: 'tester', email: 'tester@mail.com', password: 'password', password_confirmation: 'password'}}

    # User should be automatically logged in upon valid sign-up
    # So they can now access the account edit page
    get user_edit_url
    assert_response :success

    assert_template layout: 'application'
    assert_select 'h1', 'Edit your Whamazone Account'
    assert_select 'form', true
    assert_select 'form input', 8
  end

  test "should not get account edit" do
    # User should be redirected to root_path if not logged in
    get user_edit_url
    assert_redirected_to root_path
  end

  test "should get account" do
    # Sign up as a new user
    post users_path, params: {user: {username: 'test', name: 'tester', email: 'tester@mail.com', password: 'password', password_confirmation: 'password'}}

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
    post users_path, params: {user: {username: 'test', name: 'tester', email: 'tester@mail.com', password: 'password', password_confirmation: 'password'}}
    assert_redirected_to root_path
    assert_not_empty flash[:notice]
  end

  test "should not signup user" do
    post users_path, params: {user: {username: 'test', name: 'tester', email: 'tester@mail.com', password: 'password', password_confirmation: 'wrongPassword'}}
    assert_redirected_to user_signup_path
    assert_not_empty flash[:alert]
  end

end
