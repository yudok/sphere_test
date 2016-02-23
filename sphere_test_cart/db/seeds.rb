# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Item.delete_all
@item1 = Item.create!  name: "Ethiopia harrar", price: 20
@item2 = Item.create!  name: "Big Leaf tea", price: 10
@item3 = Item.create!  name: "Lipton tea", price: 20
@item4 = Item.create!  name: "Tasty tea", price: 30
@item4 = Item.create!  name: "English tea", price: 40




Sale.delete_all

@sale1 = Sale.create! discount_type: "flat" , discount: 20
@sale2 = Sale.create! discount_type: "percentage" , discount: 0.5


@sale1.sales_items.create(quantity: 3, item_id: @item2.id)
@sale2.sales_items.create(quantity: 2, item_id: @item1.id)