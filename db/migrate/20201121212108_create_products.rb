class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :category
      t.string :image_url
      t.decimal :price
      t.integer :quantityInStock
      t.boolean :has_badge
      t.boolean :is_new

      t.timestamps
    end
  end
end
