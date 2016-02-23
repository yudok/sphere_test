class SalesItems < ActiveRecord::Migration
  def change
  create_table :sales_items do |t|

  t.integer     :sale_id
  t.integer     :item_id
  t.integer     :quantity

  end
  end
end
