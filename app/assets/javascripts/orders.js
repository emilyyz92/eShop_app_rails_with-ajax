document.addEventListener("DOMContentLoaded", function(){
  nextOrderButton()
})

function nextOrderButton() {
  var button = document.getElementById("next-order-button")
  button.addEventListener("click", function() {
    var userID = button.dataset.userid
    var orderID = button.dataset.orderid
    var template = Handlebars.compile(document.getElementById("order-table-template").innerHTML)
    //get JSON of the user's next order's ID
    fetch("/users/" + userID + "/orders/" + orderID).then(resp => resp.json()).then(function(orderResp) {
      if (orderResp.next_order_id) {
        orderID = orderResp.next_order_id
        //get next order's info in JSON
        fetch("/users/" + userID + "/orders/" + orderID).then(resp => resp.json()).then(function(orderResp) {
          var products = orderResp.products
          var productWithUnits = orderResp.product_with_units
          //clear table data
          document.getElementById("table-data").innerHTML = ""
          for(var i in products) {
            var productData = {productID: products[i].id,
              productName: products[i].name,
              orderProductCount: productWithUnits[products[i].name],
              productPrice: products[i].price
            }
            //update table content with new order data
            document.getElementById("table-data").innerHTML += template(productData)
          }
        })
      } else {alert("This is your last order.")}
    })
    //reset button's order ID
    button.setAttribute("data-orderid", orderID)
  })
}
