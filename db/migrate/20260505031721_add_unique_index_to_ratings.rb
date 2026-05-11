class AddUniqueIndexToRatings < ActiveRecord::Migration[8.1]
  def change
    add_index :ratings, [:user_id, :image_id], unique: true
  end
end
