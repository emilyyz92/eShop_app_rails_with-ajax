document.addEventListener("DOMContentLoaded", function() {
  moreDetails()
})

function moreDetails() {
  var details = document.querySelectorAll(".more-details")
  for(var detail of details) {
    detail.addEventListener("click", function(e) {
      e.preventDefault();
      var productID = this.dataset.id
      fetch("/products/" + productID).then(resp => resp.json())
      .then(function(product) {
        if(product.description) {
          document.getElementById('description-' + productID).innerHTML =
          product.description
        }
        if (product.inventory > 0) {
          var availability = "In Stock"
        } else {
          var availability = "Temporarily Out of Stock"
        }
        var availItem = document.createElement("small")
        var priceItem = document.createElement("p")
        availItem.className = "card-text avail"
        availItem.innerHTML = availability
        priceItem.className = "card-text price"
        priceItem.innerHTML = "Price: $" + product.price
        let cardBody = document.getElementById("body-" + productID)
        let productDetail = document.getElementById("details-" + productID)
        cardBody.insertBefore(availItem, productDetail)
        cardBody.insertBefore(priceItem, productDetail)
        cardBody.removeChild(productDetail)
      })
    })
  }
}

// function addToCart() {
//   const forms = document.querySelectorAll("form")
//   for(var form of forms) {
//     var id = form.dataset.id
//     form.addEventListener("submit", function(e) {
//       e.preventDefault();
//       var select = document.getElementById(`inlineFormCustomSelect product-${id}`)
//       cartData = {
//         product_id: id
//         // count: select.options[select.selectedIndex].value
//       }
//       var cartID = document.getElementById("my-cart").dataset.id
//       cartID === "" ? reqData.method = "POST" : reqData.method = "PATCH"
//       let reqData = {
//         body: JSON.stringify(cartData),
//         headers: {'Content-Type': 'application/json'}
//       }
//       fetch()
//     })
//   }
// }
