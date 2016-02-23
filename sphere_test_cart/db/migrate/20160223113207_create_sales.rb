class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.float    :discount
      t.boolean  :active, default: true
      t.string   :discount_type
      t.timestamps null: false
    end
  end
end
