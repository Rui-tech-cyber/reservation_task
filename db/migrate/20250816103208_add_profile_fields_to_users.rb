class AddProfileFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string, null: false, default: "" unless column_exists?(:users, :name)
    add_column :users, :introduction, :text unless column_exists?(:users, :introduction)
    add_column :users, :avatar, :string unless column_exists?(:users, :avatar)
  end
end
