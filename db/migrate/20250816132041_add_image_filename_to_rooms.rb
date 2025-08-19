class AddImageFilenameToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :image_filename, :string, default: "default-institution-image.png", null: false
  end
end