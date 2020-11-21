require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    # New method only creates a new user object (not yet saved to database)
    @newUser = User.new(username: 'new user', name: 'Mr Test', email: 'newtest@mail.com', password: 'password')
    # Create method creates a user object and saves it to the database (if validations pass)
    @createUser = User.create(username: 'create user', name: 'Mr Test', email: 'createtest@mail.com', password: 'password')
    # Invalid user objects (username and email attributes are unique)
    @duplicateUsername = User.create(username: 'create user', name: 'Mr Test', email: 'duplicatetest@mail.com', password: 'password')
    @duplicateEmail = User.create(username: 'duplicate user', name: 'Mr Test', email: 'createtest@mail.com', password: 'password')
  end

  test 'should create/new user' do
    # Checks if user object and its parameters are valid
    assert_equal(@newUser.valid?, true)
    assert_equal(@createUser.valid?, true)
    # Checks if user object is able to be saved to the database
    assert_equal(@createUser.save, true)
    assert_equal(@newUser.save, true)
  end

  test 'should not create/new user' do
    assert_equal(@duplicateUsername.valid?, false)
    assert_equal(@duplicateEmail.valid?, false)

    assert_equal(@duplicateUsername.save, false)
    assert_equal(@duplicateEmail.save, false)
  end

  test 'should match user password' do
    assert_equal(@createUser, User.find_by(email: 'createtest@mail.com').try(:authenticate, 'password'))
  end

  test 'should not match user password' do
    assert_equal(false, User.find_by(email: 'createtest@mail.com').try(:authenticate, 'differentPassword'))
  end

  # Testing the bcrypt has_secure_password methods
  test 'should match encrypted password' do
    assert_equal(BCrypt::Password.create('password'), 'password')
    assert_equal(BCrypt::Password.create('differentPassword'), 'differentPassword')
  end

  test 'should not match encrypted password' do
    assert_not_equal(BCrypt::Password.create('password'), 'differentPassword')
    # We should get a different hash even if it is the same password value
    assert_not_equal(BCrypt::Password.create('password'), BCrypt::Password.create('password'))
    assert_not_equal(BCrypt::Password.create('password'), BCrypt::Password.create('differentPassword'))
  end

end
