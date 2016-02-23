class Item < ActiveRecord::Base

  has_many :cart_items
  has_many :sales

end
