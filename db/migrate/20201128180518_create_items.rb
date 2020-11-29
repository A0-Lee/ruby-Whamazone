class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.belongs_to :basket, foreign_key: true
      t.belongs_to :product, foreign_key: true
      t.integer :quantityOrdered

      t.timestamps
    end
  end
end
