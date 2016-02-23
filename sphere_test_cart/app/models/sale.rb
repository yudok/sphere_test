class Sale < ActiveRecord::Base

  has_many :sales_items
  has_many :items, through: :sales_items
  has_many :carts_sales

  scope :active, -> { where(active: true)}
  scope :by_discount_type, -> {order(:discount_type)}
  def self.by_discount_type
    order(:discount_type)
  end

  def item_ids
    sales_items.pluck(:item_id)
  end

  def total_discount
    if discount_type == "flat"
      discount
    else
      total_price * discount
    end
  end

  def total_price
    sales_items.map(&:unit_price).inject { |sum,n| sum + n}
  end

  end

