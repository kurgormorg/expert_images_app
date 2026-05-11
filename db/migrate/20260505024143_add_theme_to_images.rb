class AddThemeToImages < ActiveRecord::Migration[8.1]
  def change
    add_reference :images, :theme, foreign_key: true
  end
end
