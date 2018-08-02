# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create(name: "Mickey", password: "mouse", email: "mickey@gmail.com")
product1 = Product.create(name: "Mickey's Magic Gloves", price: 10.99, inventory: 100)
order1 = Order.create(user_id: 1)
item1 = Item.create(user_id: 1, product_id: 1, order_id: 1)
