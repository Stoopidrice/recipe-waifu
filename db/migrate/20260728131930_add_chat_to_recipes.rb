class AddChatToRecipes < ActiveRecord::Migration[8.1]
  def change
    add_reference :recipes, :chat, null: true, foreign_key: true
  end
end
