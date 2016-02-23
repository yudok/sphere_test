class SalesItem < ActiveRecord::Base

  belongs_to :sale
  belongs_to :item

  default_scope { order(:item_id) }

  def unit_price
    item.price * quantity
  end

end
