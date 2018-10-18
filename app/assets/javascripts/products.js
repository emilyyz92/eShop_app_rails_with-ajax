document.addEventListener("DOMContentLoaded", function() {
  moreDetails()
})

function moreDetails() {
  var details = document.querySelectorAll(".more-details")
  for(var detail of details) {
    detail.addEventListener("click", function(e) {
      e.preventDefault();
      var productID = this.dataset.id
      fetch("/products/" + productID + ".json").then(resp => resp.json())
      .then(function(productResp) {
        //create product javascript object
        if (productResp.description) {
          var product = new Product(productResp.name, productResp.id,
            productResp.inventory, productResp.price, productResp.description)
        } else {
          var product = new Product(productResp.name, productResp.id, productResp.inventory,
          productResp.price)
        }
        //expand product description
        if(product.description) {
          document.getElementById('description-' + productID).innerHTML =
          product.description
        }
        //create element, and set attributes for availability and price
        var availItem = document.createElement("small")
        var priceItem = document.createElement("p")
        availItem.className = "card-text avail"
        priceItem.className = "card-text price"
        availItem.innerHTML = product.availability()
        priceItem.innerHTML = "Price: $" + product.price
        let cardBody = document.getElementById("body-" + productID)
        let productDetail = document.getElementById("details-" + productID)
        //insert price and availability elements inside product card body
        cardBody.insertBefore(availItem, productDetail)
        cardBody.insertBefore(priceItem, productDetail)
        //remove more details button
        cardBody.removeChild(productDetail)
      })
    })
  }
}

function Product (name, id, inventory, price, description = "") {
  this.name = name
  this.id = id
  this.description = description
  this.inventory = inventory
  this.price = price
}

Product.prototype.availability = function() {
  if (this.inventory > 0) {
    return "In Stock"
  } else {
    return "Temporarily Out of Stock"
  }
}
