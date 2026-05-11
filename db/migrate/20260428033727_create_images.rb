class CreateImages < ActiveRecord::Migration[8.1]
  def change
    create_table :images do |t|
      t.string :title
      t.string :file_path
      t.string :theme

      t.timestamps
    end
  end
end
