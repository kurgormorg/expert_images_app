require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "shows main page" do
    get root_url

    assert_response :success
    assert_select "select[name='theme_id']"
    assert_select "select[name='image_id']"
    assert_includes response.body, "importmap"
  end

  test "shows about page" do
    get about_url

    assert_response :success
    assert_select "h1", I18n.t("about.title")
  end

  test "shows help page" do
    get help_url

    assert_response :success
    assert_select "h1", I18n.t("help.title")
  end
end
