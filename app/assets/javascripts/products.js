document.addEventListener("DOMContentLoaded", function() {

})

function moreDetails() {
  var products = document.querySelectorAll(".more-details")
  for(pd of products) {
    pd.addEventListener("click", function(e) {
      e.preventDefault();
      var productID = this.dataset.id
    })
  }
}
