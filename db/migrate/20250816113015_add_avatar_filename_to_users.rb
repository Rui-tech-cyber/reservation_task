class AddAvatarFilenameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar_filename, :string, default: "default-avatar-image.png", null: false
  end
end