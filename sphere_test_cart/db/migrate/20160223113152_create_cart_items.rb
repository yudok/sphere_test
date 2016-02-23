class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :item_id
      t.integer :cart_id
      t.decimal :unit_price
      t.integer :quantity
      t.decimal :total_price
      t.timestamps null: false
    end
  end
end
