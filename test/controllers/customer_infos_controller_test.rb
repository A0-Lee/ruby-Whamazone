require 'test_helper'

class CustomerInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer_info = customer_infos(:two)
    @adminAccount = users(:one)
  end

  test "should get index" do
    # Should only be accessible to admin account
    post sessions_path, params: {login: {email: 'Admin@Whamazone.com', password: 'WHAM'}}

    get customer_infos_url
    assert_response :success

    assert_template layout: 'application'
    assert_select 'h1', 'Customer Infos'
    assert_select 'hr'

  end

  test "should not get index" do
    # Only an admin account can access this page
    get customer_infos_url
    assert_not_empty flash[:alert]
    assert_redirected_to root_path
  end

  test "should get new" do
    get new_customer_info_url
    assert_response :success

    assert_template layout: 'application'
    assert_select 'h1', 'Fill in Your Personal Details'
    assert_select 'hr'
    # Check if form exists
    assert_select 'form', true
    # Note that the submit button and the hidden utf8 name counts as input fields
    assert_select 'form input', 8
  end

  test "should create customer_info" do
    assert_difference('CustomerInfo.count') do
      post customer_infos_url, params: { customer_info: { address: @customer_info.address, city: @customer_info.city, county: @customer_info.county, customerName: @customer_info.customerName, postcode: @customer_info.postcode, telephone: @customer_info.telephone, user_id: @customer_info.user_id } }
    end

    assert_redirected_to customer_info_url(CustomerInfo.last)
  end

  test "should show customer_info" do
    # @customer_info belongs to users(:two) in fixtures
    # So we login to this account to get the user session id to match with customer_info's user_id
    post sessions_path, params: {login: {email: 'Test@Mail.com', password: 'test'}}

    get customer_info_url(@customer_info)
    assert_response :success
  end

  test "should not show customer_info" do
    # User should be logged in to access their CustomerInfo
    get customer_info_url(@customer_info)
    assert_not_empty flash[:alert]
    assert_redirected_to root_path
  end

  test "should get edit" do
    # @customer_info belongs to users(:two) in fixtures
    # So we login to this account to get the user session id to match with customer_info's user_id
    post sessions_path, params: {login: {email: 'Test@Mail.com', password: 'test'}}

    get edit_customer_info_url(@customer_info)
    assert_response :success
  end

  test "should not get edit" do
    # User should be logged in to edit their CustomerInfo
    get edit_customer_info_url(@customer_info)
    assert_not_empty flash[:alert]
    assert_redirected_to root_path
  end

  test "should update customer_info" do
    # A User can only update their customer_info if they can access the edit page
    # So there's no need to check for any other conditions
    patch customer_info_url(@customer_info), params: { customer_info: { address: @customer_info.address, city: @customer_info.city, county: @customer_info.county, customerName: @customer_info.customerName, postcode: @customer_info.postcode, telephone: @customer_info.telephone, user_id: @customer_info.user_id } }
    assert_redirected_to customer_info_url(@customer_info)
  end

end
