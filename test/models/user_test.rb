require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example Uzivatel", email: "uzivatel@seznam.cz", password: "foobar", password_confirmation: "foobar")
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

  test "email address should be lowercase" do
    email = "Foo@ExAMPLe.CoM"
    @user.email = email;
    @user.save
    assert_equal email.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "microposts of user should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    michael = users(:michael)
    lumir = users(:lumir)
    assert_not michael.following?(lumir)
    michael.follow(lumir)
    assert michael.following?(lumir)
    assert lumir.followers.include?(michael)
    michael.unfollow(lumir)
    assert_not michael.following?(lumir)
  end

  # test "the truth" do
  #   assert true
  # end
end
