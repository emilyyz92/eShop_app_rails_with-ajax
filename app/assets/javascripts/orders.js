document.addEventListener("DOMContentLoaded", function(){
  nextOrderButton()
})

function nextOrderButton() {
  var button = document.getElementById("next-order-button")
  button.addEventListener("click", function() {
    var userID = button.dataset.userid
    var orderID = button.dataset.orderid
    var template = Handlebars.compile(document.getElementById("order-table-template").innerHTML)
    //get JSON of next order's ID
    fetch("/users/" + userID + "/orders/" + orderID).then(resp => resp.json()).then(function(orderResp) {
      orderID = orderResp.next_order_id
    })
    //get next order's info in JSON
    fetch("/users/" + userID + "/orders/" + orderID).then(resp => resp.json()).then(function(orderResp) {
      var products = orderResp.products
      var productWithUnits = orderResp.product_with_units
      for(var product in products) {
        var productData = {productID: product.id,
          productName: product.name,
          orderProductCount: productWithUnits[product.name],
          productPrice: product.price
        }
      }
    })
  })
}
