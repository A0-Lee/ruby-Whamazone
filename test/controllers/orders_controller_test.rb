require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
    @basket = baskets(:one)
  end

  test "should not get index" do
    get orders_url
    assert_redirected_to root_path
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { basket_id: @basket.id, card_number: @order.card_number,  message: @order.message, svc_number: @order.svc_number, orderTotal: @order.orderTotal } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    # We have to create a new Order record using this method, as fixtures don't allow associations with different existing records
    # In this case, we need an existing Basket record to create our Order record (as an Order cannot be created without a Basket id that belongs to an existing Basket record)
    @newOrder = Order.create(basket_id: @basket.id, card_number: 1234123412341234, svc_number: 123, deliveryDate: Time.current())
    # Otherwise it will give us a nil id if we used the @order variable fixture, for the reasons above
    get order_url(@newOrder)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { basket_id: @order.basket_id, card_number: @order.card_number, deliveryDate: @order.deliveryDate, message: @order.message, svc_number: @order.svc_number, orderTotal: @order.orderTotal } }
    assert_response :success
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
