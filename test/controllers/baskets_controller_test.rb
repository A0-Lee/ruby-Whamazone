require 'test_helper'

class BasketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @basket = baskets(:one)
  end

  test "should get index" do
    # Should only be accessible to admin account
    get baskets_url
    assert_redirected_to root_path
  end

  test "should get new" do
    get new_basket_url
    assert_response :success
  end

  test "should create basket" do
    assert_difference('Basket.count') do
      post baskets_url, params: { basket: { address: @basket.address, city: @basket.city, county: @basket.county, customerName: @basket.customerName, postcode: @basket.postcode, user_id: @basket.user_id } }
    end

    assert_redirected_to basket_url(Basket.last)
  end

  test "should not show basket" do
    # Basket session id is nil so it should not give permission to view basket
    get basket_url(@basket)
    assert_redirected_to root_path
  end

  test "should not get edit" do
    # Basket session id is nil, so should redirect to root path
    get edit_basket_url(@basket)
    assert_redirected_to root_path
  end

  test "should update basket" do
    patch basket_url(@basket), params: { basket: { address: @basket.address, city: @basket.city, county: @basket.county, customerName: @basket.customerName, postcode: @basket.postcode, user_id: @basket.user_id } }
    assert_redirected_to basket_url(@basket)
  end

  test "should destroy basket" do
    assert_difference('Basket.count', -1) do
      delete basket_url(@basket)
    end

    assert_redirected_to baskets_url
  end
end
