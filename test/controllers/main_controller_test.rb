require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get main_home_url
    assert_response :success

    assert_template layout: 'application'
    assert_select 'h1', 'Welcome to Whamazone!'
    assert_select 'p', 'The best (and even better) e-commerce business since 2020!'
  end

  test "should get contact" do
    get main_contact_url
    assert_response :success

    assert_template layout: 'application'
    assert_select 'h1', 'Contact Us'
    assert_select 'p', 'See our FAQ and our Customer Support section below for assistance:'
  end

  test "should get about" do
    get main_about_url
    assert_response :success

    assert_template layout: 'application'
    assert_select 'h1', 'About Us'
    assert_select 'p', 'The Whamazone Wikipedia - Everything you need to know about us.'
  end

  test "should get login" do
    get user_login_url
    assert_response :success

    assert_template layout: 'application'
    assert_select 'h1', 'Login with your Whamazone Account'
  end
end
