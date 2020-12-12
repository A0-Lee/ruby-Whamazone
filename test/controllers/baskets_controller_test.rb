require 'test_helper'

class BasketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @basket = baskets(:one)
    @adminAccount = users(:one)
    @customerInfo = customer_infos(:one)
    @product = products(:one)
  end

  test "should get index" do
    # Should only be accessible to admin account
    post sessions_path, params: {login: {email: 'Admin@Whamazone.com', password: 'WHAM'}}
    get baskets_url

    assert_response :success

    assert_template layout: 'application'
    assert_select 'h1', 'User Baskets'
    assert_select 'hr'
  end

  test "should not get index" do
    get baskets_url
    assert_not_empty flash[:alert]
    assert_redirected_to root_path
  end

  test "should show basket" do
    # We create a new basket and set a new basket session
    post items_path(product_id: @product)
    # Get the basket we just created
    @recentBasket = Basket.last(1)
    # We should be able to see the basket as the session id and basket id match
    get basket_url(@recentBasket)

    assert_response :success
  end

  test "should not show basket" do
    # Should not show basket as user is not logged in
    get baskets_url
    assert_not_empty flash[:alert]
    assert_redirected_to root_path
  end

  test "should create basket" do
    assert_difference('Basket.count') do
      post baskets_url, params: { basket: { customer_info_id: @customerInfo } }
    end

    assert_redirected_to basket_url(Basket.last)
  end

  test "should destroy basket" do
    assert_difference('Basket.count', -1) do
      delete basket_url(@basket)
    end

    assert_not_empty flash[:notice]
    assert_redirected_to baskets_url
  end

end
