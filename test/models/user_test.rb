require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User",
                     email: "example@email.com")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should not be blank" do
    @user.name = "  "
    assert_not @user.valid?
  end
  
  test "email should not be blank and should be unique" do
    @user.email = "  "
    assert_not @user.valid?
  end
  
  test "should reject duplicate email" do
    user2 = @user.dup
    user2.save
    assert_not @user.valid?
  end
end
