require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "should have many readings" do
    assert_respond_to @user, :readings
  end

  test "should have many books through readings" do
    assert_respond_to @user, :books
  end
end
