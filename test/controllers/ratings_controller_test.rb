require "test_helper"

class RatingsControllerTest < ActionDispatch::IntegrationTest
  test "creates or updates rating for signed in user" do
    sign_in users(:one)

    post ratings_url, params: { image_id: images(:city).id, value: 4 }

    assert_redirected_to root_url(theme_id: images(:city).theme_id, image_id: images(:city).id)
    assert_equal 4, users(:one).ratings.find_by(image: images(:city)).value
  end
end
