require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(username: 'testing', name: 'Mr Test', email: 'test@mail.com', password: 'password')
  end

  test 'should create user' do
    assert @user.valid?
  end

  # Testing the bcrypt has_secure_password method
  test 'should match encrypted password' do
    assert_equal(BCrypt::Password.create('password'), 'password')
  end
end
