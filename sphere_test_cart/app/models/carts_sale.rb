class CartsSale < ActiveRecord::Base

belongs_to :sale
belongs_to :cart

end
