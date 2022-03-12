require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example Uzivatel", email: "uzivatel@seznam.cz")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.name = "a" * 200 + "@seznam.cz"
    assert_not @user.valid?
  end

  test "email must contain @ and must not contain any other special characters" do
    invalid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                          first.last@foo.jp alice+bob@baz.cn]
    invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        assert @user.valid?, "#{invalid_address.inspect} should be valid"
      end
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  # test "the truth" do
  #   assert true
  # end
end
