class AddUserInfoToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :username, :string
    add_column :users, :preferences, :text
    add_column :users, :dislikes, :text
    add_column :users, :unit_preference, :string
  end
end
