require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:one)
    @product = products(:one)
  end

  test "should not get index" do
    get items_url
    assert_redirected_to root_path
  end

  test "should get new" do
    get new_item_url
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post items_url, params: { product_id: @product.id, quantityOrdered: 1 }
    end

    # Will create a new basket, as part of the set_basket setup method
    assert_redirected_to basket_url(Basket.last)
  end

  test "should show item" do
    get item_url(@item)
    assert_response :success
  end

  test "should get edit" do
    get edit_item_url(@item)
    assert_response :success
  end

  test "should update item" do
    patch item_url(@item), params: { item: { basket_id: @item.basket_id, product_id: @item.product_id } }
    assert_response :success
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete item_url(@item)
    end

    assert_redirected_to items_url
  end
end
