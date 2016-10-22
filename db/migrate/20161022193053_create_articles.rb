class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :total_in_shelf
      t.integer :total_in_vault

      t.belongs_to :store_id, index: true

      t.timestamps null: false
    end
  end
end
