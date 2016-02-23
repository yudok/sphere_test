class ItemsController < ApplicationController

  def index
    @items = Item.all
    @cart_item = current_cart.cart_items.new
  end
end
