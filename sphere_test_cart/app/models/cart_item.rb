class CartItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :cart

  delegate :subtotal_with_discount!, to: :cart

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :item_present
  validate :cart_present

  before_save :finalize
  after_save :subtotal_with_discount!
  after_destroy :subtotal_with_discount!

  default_scope { order(:item_id) }

  def unit_price
    if persisted?
      self[:unit_price]
    else
      item.price
    end
  end

private
  def item_present
    if item.nil?
      errors.add(:item, "is not valid or is not active.")
    end
  end

  def cart_present
    if item.nil?
      errors.add(:cart, "is not a valid cart.")
    end
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end

