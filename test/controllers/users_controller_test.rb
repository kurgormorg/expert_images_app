require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "shows profile for signed in user" do
    sign_in users(:one)

    get user_url

    assert_response :success
    assert_select "h1", I18n.t("profile.title")
    assert_select "img.thumb"
  end

  test "redirects guest to login" do
    get user_url

    assert_redirected_to new_user_session_url
  end
end
