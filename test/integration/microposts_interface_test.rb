require "test_helper"

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    post microposts_path, params: { micropost: { content: "" } }
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2'  # Correct pagination link
    # Valid submission
    content = "This micropost really ties the room together"
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { content: content,
                                                   image:   image } }
    end
    assert assigns(:micropost).image.attached?
    follow_redirect!
    assert_match content, response.body
    # Delete a post.
    assert_select 'a', 'delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    # Visit a different user (no delete links).
    get user_path(users(:lena))
    assert_select 'a', { text: 'delete', count: 0 }
  end

end
