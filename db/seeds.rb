# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create(name: "Mickey", password: "mouse", email: "mickey@gmail.com", phone_number: "1234567890")
product1 = Product.create(name: "Mickey's Magic Gloves", price: 10.99, inventory: 100)
order1 = Order.create(user_id: 1)
item1 = Item.create(product_id: 1, order_id: 1)

DATA = {
  product_keys: ["name", "inventory", "price", "description"],
  products: [
    ["Flying Carpet", 100, 19.99, "Flying carpet comfortable enough for a family of 8! Including invisible mode to muggles and 8 speed adjustments. Call us for more information!"],
    ["Invisibility Cloak", 5, 89.99, "Enough said by the name, being invisible the second you put me on!"],
    ["Chocolate Frog", 1000, 3.99, "Collect different characters of celebrities cards inside the chocolage frog package, across the wizard and muggle worlds. Comes in milk and dark chocolate flavors, and season special flavors like pumpkin and rum filled chocolates."],
    ["Working Shoes", 70, 8.99, "Sturdy working shoes"],
    ["Dragon Skin Gloves", 100, 14.99, "All purpose working gloves"],
    ["Magic Hats", 20, 16.99, "Handsome hats that also do magic tricks"]
  ],
  user_keys: ["name", "email", "password", "phone_number", "admin"],
  users: [
    ["Winnie the Pooh", "pooh@disney.com", "piglet", "2222222222"],
    ["Jerry the Mouse", "jerry@gmail.com", "Tom", "3333333333"],
    ["Simba", "simba@jungle.com", "King", "5555555555", true]
  ]
}

def make_users
  DATA[:users].each do |user|
    new_user = User.new
    user.each_with_index do |attribute, i|
      new_user.send(DATA[:user_keys][i]+"=", attribute)
    end
    new_user.save
  end
end

def make_products
  DATA[:products].each do |product|
    new_product = Product.new
    product.each_with_index do |attribute, i|
      new_product.send(DATA[:product_keys][i]+"=", attribute)
    end
    new_product.save
  end
end

make_users
make_products
