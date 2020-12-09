require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get root_path
    assert_response :success
  end


  test "should show product" do
    get product_url(@product)
    assert_response :success
  end


end
