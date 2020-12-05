class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.belongs_to :basket, foreign_key: true
      t.string :card_number
      t.string :svc_number
      t.string :telephone
      t.text :message
      t.decimal :totalCost
      t.datetime :orderDate
      t.datetime :deliveryDate

      t.timestamps
    end
  end
end
