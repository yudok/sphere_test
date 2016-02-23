class CreateCartsSales < ActiveRecord::Migration
  def change
    create_table :carts_sales do |t|
      t.integer :cart_id
      t.integer :sale_id
      t.timestamps null: false
    end
  end
end
