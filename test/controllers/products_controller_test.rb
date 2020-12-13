require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success

    assert_template layout: 'application'
    assert_select 'h1', 'All Whamazone Products'
    assert_select 'hr'
  end


  test "should show product" do
    get product_url(@product)
    assert_response :success
  end


end
