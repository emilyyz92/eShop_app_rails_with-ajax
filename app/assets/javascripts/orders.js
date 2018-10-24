document.addEventListener("DOMContentLoaded", function(){

})

function nextOrderButton() {
  var button = document.getElementById("next-order-button")
  button.addEventListener("click", function() {
    var userID = button.dataset.userid
    var orderID = button.dataset.orderid
  })
}
