require 'test_helper'

class BasketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @basket = baskets(:one)
    @customerInfo = customer_infos(:one)
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
      post baskets_url, params: { basket: { customer_info_id: @customerInfo } }
    end

    assert_redirected_to basket_url(Basket.last)
  end

end
