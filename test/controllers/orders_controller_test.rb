require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
    @basket = baskets(:one)
    @items = items(:one)
    @product = products(:one)
  end

  test "should get index" do
    # Should only be accessible if User is logged in
    post sessions_path, params: {login: {email: 'Test@Mail.com', password: 'test'}}

    get orders_url
    assert_response :success

    assert_template layout: 'application'
    assert_select 'h1', 'Your Orders'
    assert_select 'hr'
  end

  test "should not get index" do
    # Should only be accessible if User is logged in
    get orders_url
    assert_not_empty flash[:alert]
    assert_redirected_to root_path
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      # First we add the product to our Basket (creates Basket and sets session)
      post items_path, params: {product_id: @product.id, quantityOrdered: 1}
      post orders_url, params: { order: { basket: @basket, card_number: @order.card_number,  message: @order.message, svc_number: @order.svc_number, orderTotal: @order.orderTotal } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    # Order belongs to this users(:two), so they should be able to access this
    post sessions_path, params: {login: {email: 'Test@Mail.com', password: 'test'}}

    get order_url(@order)
    assert_response :success
  end

  test "should not show order" do
    get order_url(@order)
    assert_not_empty flash[:alert]
    assert_redirected_to root_path
  end


end
