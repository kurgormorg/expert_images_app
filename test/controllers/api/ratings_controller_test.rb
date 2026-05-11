require "test_helper"

class Api::RatingsControllerTest < ActionDispatch::IntegrationTest
  test "saves rating and returns average" do
    sign_in users(:one)

    post api_ratings_url,
      params: { image_id: images(:city).id, value: 4 },
      as: :json

    assert_response :success
    body = JSON.parse(response.body)
    assert_equal true, body["success"]
    assert_equal 4, body["value"]
    assert_equal 4.0, body["average"]
  end
end
