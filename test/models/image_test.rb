require "test_helper"

class ImageTest < ActiveSupport::TestCase
  test "requires unique file path inside theme" do
    image = Image.new(
      title: "Duplicate forest",
      file_path: images(:forest).file_path,
      theme: images(:forest).theme
    )

    assert_not image.valid?
  end
end
