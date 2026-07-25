class AddRecipesToMessages < ActiveRecord::Migration[8.1]
  def change
    add_column :messages, :recipes, :json
  end
end
