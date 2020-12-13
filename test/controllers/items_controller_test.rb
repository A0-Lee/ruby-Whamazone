require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:one)
    @product = products(:one)
    @basket = baskets(:one)
    @customerInfo = customer_infos(:one)
  end

  test "should get index" do
    # Should only be accessible to admin account
    # In this case, users(:one) in our users.yml fixture is our admin account
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
      post items_path, params: { product_id: @product.id, quantityOrdered: 1 }
    end

    # Will create a new basket, as part of the set_basket setup method
    assert_redirected_to basket_url(Basket.last)
  end

  test "should remove item" do
    # We create a new basket and set a new basket session by adding a product
    post items_url, params: { product_id: @product.id, quantityOrdered: 1 }

    # The basket holds @product which is linked to @item
    assert_difference('Item.count', -1) do
      delete remove_item_url, params: { id: @item.id}
    end
  end

end
