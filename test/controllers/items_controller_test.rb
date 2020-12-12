require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:one)
    @product = products(:one)

  end

  test "should get index" do
    # Should only be accessible to admin account
    post sessions_path, params: {login: {email: 'Admin@Whamazone.com', password: 'WHAM'}}

    get items_url
    assert_response :success

    assert_template layout: 'application'
    assert_select 'h1', 'Basket\'s Items'
    assert_select 'hr'

  end

  test "should not get index" do
    get items_url
    assert_redirected_to root_path
  end


  test "should create item" do
    assert_difference('Item.count') do
      post items_url, params: { product_id: @product.id, quantityOrdered: 1 }
    end

    # Will create a new basket, as part of the set_basket setup method
    assert_redirected_to basket_url(Basket.last)
  end

end
