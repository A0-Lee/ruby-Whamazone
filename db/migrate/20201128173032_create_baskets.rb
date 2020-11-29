class CreateBaskets < ActiveRecord::Migration[5.2]
  def change
    create_table :baskets do |t|
      t.belongs_to :user, foreign_key: true
      t.string :customerName
      t.string :address
      t.string :city
      t.string :county
      t.string :postcode

      t.timestamps
    end
  end
end
