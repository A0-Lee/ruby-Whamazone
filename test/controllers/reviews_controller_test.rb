require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @review = reviews(:one)
    @product = products(:one)
  end

  test "should get index" do
    # First we sign up and login a user (signup automatically logins user)
    # This is important as reviews controller checks for a user_id session
    post users_path, params: {user: {username: 'test', name: 'Mr Test', email: 'test@mail.com', password: 'password', password_confirmation: 'password'}}

    get reviews_url
    assert_response :success
  end

  test "should not get index" do
    #Should not get index as user is not logged in
    get reviews_url
    assert_redirected_to root_path
  end

  test "should get new" do
    post users_path, params: {user: {username: 'test', name: 'Mr Test', email: 'test@mail.com', password: 'password', password_confirmation: 'password'}}

    get new_product_review_url(product_id: @product.id)
    assert_response :success
  end

  test "should not get new" do
    # Should not get new review as user has to be logged in to write a review
    get new_product_review_url(product_id: @product.id)
    assert_redirected_to root_path
  end

  test "should create review" do
    # First we sign up and login a user (signup automatically logins user)
    post users_path, params: {user: {username: 'test', name: 'Mr Test', email: 'test@mail.com', password: 'password', password_confirmation: 'password'}}

    assert_difference('Review.count') do
      post reviews_url, params: { review: { comment: @review.comment, product_id: @review.product.id, rating: @review.rating, title: @review.title} }
    end

    assert_redirected_to product_url(@product)
  end

  test "should not show review" do
    get review_url(@review)
    assert_redirected_to root_path
  end

  test "should not get edit" do
    get edit_review_url(@review)
    assert_redirected_to root_path
  end

  test "should update review" do
    patch review_url(@review), params: { review: { comment: @review.comment, product_id: @review.product_id, rating: @review.rating, title: @review.title, user_id: @review.user_id } }
    assert_redirected_to reviews_path
  end

  test "should destroy review" do
    assert_difference('Review.count', -1) do
      delete review_url(@review)
    end

    assert_redirected_to reviews_url
  end
end
