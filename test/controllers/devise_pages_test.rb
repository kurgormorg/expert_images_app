require "test_helper"

class DevisePagesTest < ActionDispatch::IntegrationTest
  test "shows login page" do
    get new_user_session_url

    assert_response :success
    assert_select "h1", I18n.t("auth.login")
  end

  test "shows registration errors" do
    post user_registration_url, params: {
      user: { email: "", password: "123", password_confirmation: "456" }
    }

    assert_response :unprocessable_content
    assert_select ".form-errors"
  end

  test "shows invalid login warning" do
    post user_session_url, params: {
      user: { email: "missing@example.com", password: "wrong-password" }
    }

    assert_response :unprocessable_content
    assert_select ".flash-danger"
  end
end
