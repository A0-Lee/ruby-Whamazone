require 'test_helper'

class CustomerInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer_info = customer_infos(:one)
  end

  test "should not get index" do
    get customer_infos_url
    assert_redirected_to root_path
  end

  test "should get new" do
    get new_customer_info_url
    assert_response :success
  end

  test "should create customer_info" do
    assert_difference('CustomerInfo.count') do
      post customer_infos_url, params: { customer_info: { address: @customer_info.address, city: @customer_info.city, county: @customer_info.county, customerName: @customer_info.customerName, postcode: @customer_info.postcode, telephone: @customer_info.telephone, user_id: @customer_info.user_id } }
    end

    assert_redirected_to customer_info_url(CustomerInfo.last)
  end

  test "should show customer_info" do
    get customer_info_url(@customer_info)
    assert_response :success
  end

  test "should get edit" do
    get edit_customer_info_url(@customer_info)
    assert_response :success
  end

  test "should update customer_info" do
    patch customer_info_url(@customer_info), params: { customer_info: { address: @customer_info.address, city: @customer_info.city, county: @customer_info.county, customerName: @customer_info.customerName, postcode: @customer_info.postcode, telephone: @customer_info.telephone, user_id: @customer_info.user_id } }
    assert_redirected_to customer_info_url(@customer_info)
  end

  test "should destroy customer_info" do
    assert_difference('CustomerInfo.count', -1) do
      delete customer_info_url(@customer_info)
    end

    assert_redirected_to customer_infos_url
  end
end
