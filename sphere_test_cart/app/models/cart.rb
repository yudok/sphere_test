class Cart < ActiveRecord::Base
has_many :cart_items
  has_many :carts_sales
  has_many :sales, through: :carts_sales

  def subtotal
    cart_items.collect { |ci| ci.valid? ? (ci.quantity * ci.unit_price) : 0 }.sum
  end

  def sale_ids
    carts_sales.pluck(:sale_id).uniq
  end

  def item_ids
    cart_items.pluck(:item_id).uniq
  end

  def discount_availiable? sale
    compare_items(sale) && compare_quantities(sale)
  end

  def compare_items sale
    (sale.item_ids & item_ids) == sale.item_ids
  end

  def compare_quantities sale
    sale.sales_items.all? do |si|
      si.quantity <= cart_items.where(item_id: si.item_id).pluck(:quantity).inject{|sum,x| sum + x}
    end
  end

  def all_sales_discount
    sales.any? ? sales.map(&:total_discount).inject{ |sum,x| sum + x } : 0
  end

  def subtotal_with_discount!
    Sale.active.by_discount_type.each do |sale|
      if discount_availiable?(sale) && !sale_ids.include?(sale.id) #uslovie skidki vipolneno, skidka ne aktivna
        carts_sales.create(sale_id: sale.id)
      elsif !discount_availiable?(sale) && sale_ids.include?(sale.id) #uslovie skidki ne vipolneno, skidka aktivna
        carts_sales.find_by(sale_id: sale.id).destroy
      end
    end

    self[:total_price] = subtotal - all_sales_discount

    save
    puts "-------------------------------------------------------------------------------"
    puts "00000000000000   #{self[:total_price]}  000000000000000000000 "
  end
end

