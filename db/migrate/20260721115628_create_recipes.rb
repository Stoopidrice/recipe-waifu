class CreateRecipes < ActiveRecord::Migration[8.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.text :instructions
      t.integer :difficulty
      t.text :ingredients
      t.integer :calories
      t.integer :prep_time
      t.integer :cook_time
      t.integer :servings
      t.integer :rating
      t.text :system_prompt
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
