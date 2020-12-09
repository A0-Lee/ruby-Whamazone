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
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { basket_id: @order.basket, card_number: @order.card_number, deliveryDate: @order.deliveryDate, message: @order.message, svc_number: @order.svc_number, orderTotal: @order.orderTotal } }
    assert_response :success
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
