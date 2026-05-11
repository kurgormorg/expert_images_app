themes = {
  "Город" => [
    { title: "Городская панорама", file_path: "city.jpg" },
    { title: "Небоскребы", file_path: "skyscrapers.jpg" }
  ],
  "Природа" => [
    { title: "Лес", file_path: "forest.jpg" },
    { title: "Озеро", file_path: "lake.jpg" },
    { title: "Горы", file_path: "mountains.jpg" }
  ]
}

themes.each do |theme_name, images|
  theme = Theme.find_or_create_by!(name: theme_name)

  images.each do |attrs|
    matching_images = theme.images.where(file_path: attrs[:file_path]).order(:id).to_a
    image = matching_images.find { |item| item.title == attrs[:title] } || matching_images.first || theme.images.build

    duplicate_images = matching_images - [image]
    duplicate_images.each do |duplicate|
      duplicate.ratings.find_each do |rating|
        existing_rating = Rating.find_by(user_id: rating.user_id, image_id: image.id)

        if existing_rating
          existing_rating.update!(value: rating.value)
          rating.destroy!
        else
          rating.update!(image: image)
        end
      end

      duplicate.destroy!
    end

    image.title = attrs[:title]
    image.file_path = attrs[:file_path]
    image.theme = theme
    image.save!
  end
end
