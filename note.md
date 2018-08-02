Online Shop

User:

view account
view products
add products in cart (on products index page)
use bcrypt for password hashing
use omniauth (google) - add this feature later
Admin user:

add/delete/edit products
see all orders
Order belongs to User User has many items, and many products and orders through items Order has_many Products, Product has many Orders, through items Item belongs to Order, Product, and User
