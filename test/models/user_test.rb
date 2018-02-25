require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "is expected to be valid" do
    assert @user.valid?
  end

  test "expect user name to be presence" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "expect user email to be presence" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "expect user name is not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "expect user email is not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "expect user email to be valid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "expect user email to be unique" do
    @user.save!
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    assert_not duplicate_user.valid?
  end
end
