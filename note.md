Online Shop

Backend functionalities:
User -
view account
view products
add products in cart (on products index page)
use bcrypt for password hashing
use omniauth (google) - add this feature later
Admin user:
add/delete/edit products
see all orders

Frontend functionalities + refine backend:
1. products AJAX API - home page, list products and have button for product details; render products details on home page using javascript
2. does CartController make better sense when adding products to cart?
3. Use JavaScript to create an order, add product to cart, show cart;
4. At users/:id/orders page, use javascript to show order details

control flow for an order:
1. View Products - home page, AJAX
2. add to cart - cart controller (cart belongs to user, has many items, has many products thru items;)
3. user home page shows orders and current cart - use JS so that when click on cart, shows item (product details) and quantities
3. place order
4. order confirmed
5. order fulfilled
