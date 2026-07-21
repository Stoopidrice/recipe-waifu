class CreateConditions < ActiveRecord::Migration[8.1]
  def change
    create_table :conditions do |t|
      t.references :allergy, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
