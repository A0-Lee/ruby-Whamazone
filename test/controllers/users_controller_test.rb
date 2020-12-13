require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:two)
  end

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

  test "should not get signup" do
    # Logged in users should not be able to access the sign-up page
    # In this case, we login using users(:two) in the users.yml fixture
    post sessions_path, params: {login: {email: 'Test@Mail.com', password: 'test'}}
    get user_signup_url
    assert_redirected_to root_path
    assert_not_empty flash[:alert]
  end

  test "should update user account" do
    # Login into our user account
    post sessions_path, params: {login: {email: 'Test@Mail.com', password: 'test'}}
    # Edit details on account edit form, in this case we are changing all of the fields
    patch user_path(@user), params: {user: {username: 'different', name: 'tester', email: 'different@mail.com', password: 'password', password_confirmation: 'password'}}
    assert_redirected_to root_path
    assert_not_empty flash[:notice]
    # Check if a user with the username 'different' and email 'different@mail.com' now exists in the database
    assert_equal(true, !!User.find_by(username: 'different', email: 'different@mail.com'))
    # Likewise, check if a user with the username 'test' and email 'Test@Mail.com' no longer exists (our old account details)
    assert_equal(false, !!User.find_by(username: 'Test', email: 'Test@Mail.com'))
  end

  test "should not update user account" do
    # Login into our user account
    post sessions_path, params: {login: {email: 'Test@Mail.com', password: 'test'}}

    # Try to edit details with existing username and email, these are users(:three) details in the users.yml fixtures
    patch user_path(@user), params: {user: {username: 'Different', email: 'Different@Mail.com' }}
    assert_redirected_to user_edit_url
    assert_not_empty flash[:alert]
  end

  test "should get account edit" do
    # Login to our User account, as only logged in users can access their own edit page
    post sessions_path, params: {login: {email: 'Test@Mail.com', password: 'test'}}

    get user_edit_url
    assert_response :success

    assert_template layout: 'application'
    assert_select 'h1', 'Edit your Whamazone Account'
    assert_select 'form', true
    assert_select 'form input', 7
  end

  test "should not get account edit" do
    # User should be redirected to root_path if not logged in
    get user_edit_url
    assert_redirected_to root_path
  end

  test "should get account page" do
    # Login to our User account
    post sessions_path, params: {login: {email: 'Test@Mail.com', password: 'test'}}

    # User should be automatically logged in upon valid sign-up
    get user_account_url
    assert_response :success
    assert_not_empty flash[:notice]

    assert_template layout: 'application'
    assert_select 'h1', 'My Whamazone Account'
    assert_select 'p', 'Your account details:'
  end

  test "should not get account page" do
    # Users can only access their account page if logged in
    get user_account_url
    assert_redirected_to root_path
    assert_not_empty flash[:alert]
  end

  test "should create user" do
    # Should sign-up and create new user
    post users_path, params: {user: {username: 'test', name: 'tester', email: 'tester@mail.com', password: 'password', password_confirmation: 'password'}}
    assert_redirected_to root_path
    assert_not_empty flash[:notice]
  end

  test "should not create user" do
    # Should not sign-up user as password fields do not match
    post users_path, params: {user: {username: 'test', name: 'tester', email: 'tester@mail.com', password: 'password', password_confirmation: 'wrongPassword'}}
    assert_redirected_to user_signup_path
    assert_not_empty flash[:alert]
  end

end
