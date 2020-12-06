class CreateCustomerInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_infos do |t|
      t.belongs_to :user, foreign_key: true
      t.string :customerName
      t.string :telephone
      t.string :address
      t.string :city
      t.string :county
      t.string :postcode

      t.timestamps
    end
  end
end
