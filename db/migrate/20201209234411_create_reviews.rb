class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.belongs_to :product, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.text :comment
      t.integer :rating

      t.timestamps
    end
  end
end
