document.addEventListener("DOMContentLoaded", function() {
  moreDetails()
})

// function sortProducts() {
//   var sortButton = document.getElementById("sort-products")
//   sortButton.addEventListener("click", function() {
//     fetch("/products.json")
//       .then(resp => resp.json())
//       .then(function(productsResp) {
//         var sorted_products = productsResp
//         sorted_products.sort(compareProduct(a, b))
//       })
//   })
// }

// function compareProduct(a, b) {
//   var nameA = a.name.toUpperCase(); // ignore upper and lowercase
//   var nameB = b.name.toUpperCase(); // ignore upper and lowercase
//   if (nameA < nameB) {
//     return -1;
//   }
//   if (nameA > nameB) {
//     return 1;
//   }
//   // names must be equal
//   return 0;
// }

function moreDetails() {
  var details = document.querySelectorAll(".more-details")
  for(var detail of details) {
    detail.addEventListener("click", function(e) {
      e.preventDefault();
      var productID = this.dataset.id
      //can also specify json in headers' request
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
        expandDetails(product)
      })
    })
  }
}

function expandDetails(product) {
  var template = Handlebars.compile(
    document.getElementById("product-detail-template").innerHTML)
  var newDetails = template({
    productID: product.id,
    description: product.description,
    availability: product.availability(),
    price: product.price})
  let cardBody = document.getElementById("body-" + product.id)
  let detailButton = document.getElementById("details-button-" + product.id)
  let detailsBody = document.getElementById("details-body-" + product.id)
  detailsBody.innerHTML = newDetails
}

class Product  {
  constructor(name, id, inventory, price, description = "") {
    this.name = name
    this.id = id
    this.description = description
    this.inventory = inventory
    this.price = price
  }

  availability() {
    if (this.inventory > 0) {
      return "In Stock"
    } else {
      return "Temporarily Out of Stock"
    }
  }

}
