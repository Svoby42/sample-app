require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get root" do
    get root_path
    assert_response :success
    assert_select "title", "Domů | Ruby on Rails stránka"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Domů | Ruby on Rails stránka"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | Ruby on Rails stránka"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | Ruby on Rails stránka"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Kontakt | Ruby on Rails stránka"
  end

end
