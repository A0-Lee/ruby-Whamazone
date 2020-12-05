require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { basket_id: @order.basket_id, card_number: @order.card_number, deliveryDate: @order.deliveryDate, message: @order.message, orderDate: @order.orderDate, svc_number: @order.svc_number, totalCost: @order.totalCost } }
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
    patch order_url(@order), params: { order: { basket_id: @order.basket_id, card_number: @order.card_number, deliveryDate: @order.deliveryDate, message: @order.message, orderDate: @order.orderDate, svc_number: @order.svc_number, totalCost: @order.totalCost } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end