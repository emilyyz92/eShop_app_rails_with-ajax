document.addEventListener("DOMContentLoaded", function() {
  addToCart()
  viewCart()
})
function addToCart() {
  const forms = document.querySelectorAll("form")
  for(var form of forms) {
    submitForm(form)
  }
}

function submitForm(form) {
  form.addEventListener("submit", function(e) {
    e.preventDefault();
    //get ID, units and user ID that's associated with the cart
    var currentForm = e.srcElement
    var id = currentForm.dataset.productid
    var units = currentForm.elements[0].value
    var user_id = document.getElementById("my-cart").dataset.userid
    var cartData = {
      product_id: id,
      count: units
    }
    //associate the cart with user if user is logged in
    if(user_id !== "") {cartData.user_id = user_id}
    var cart = document.getElementById("my-cart")
    let reqData = {
      body: JSON.stringify(cartData),
      headers: {'Content-Type': 'application/json'}
    }
    //if there is no cart ID, create cart, and store cart ID in the data attribute
    if(cart.dataset.cartid === "") {
      reqData.method = "POST"
      fetch("/carts", reqData).then(resp => resp.json()).then(function(cartResp) {
        alert("Items added to cart")
        //set cart ID after cart created
        cart.setAttribute('data-cartid', cartResp['id'])
      })
    } else {
      //else, update cart
      reqData.method = "PATCH"
      fetch("/carts/" + cart.dataset.cartid, reqData).then(resp => resp.json()).then(function(resp) {
        alert("Items added to cart")
      })
    }
  })
}

function viewCart() {
  const cart = document.getElementById("my-cart")
  cart.addEventListener("click", function(e) {
    if (this.dataset.cartid !== "") {
      fetch("/carts/" + this.dataset.cartid).then(resp => resp.json()).then(function(cart) {
        var modalBody = document.querySelector(".modal-body")
        modalBody.innerHTML = "<ol></ol>"
        for (const key in cart.product_with_units) {
          modalBody.innerHTML += "<li>" +
          key + " * " + cart.product_with_units[key] + "</li>"
        }
        modalBody.innerHTML += "<hr><p>Total Price: " + cart.total + "</p>"
      })
    } else {
      alert("Your cart is empty. Add some items!")
    }
  })
}

function submitOrder() {
  
}
