document.addEventListener("DOMContentLoaded", function() {

})

function deleteButton() {
  const delete = document.getElementById('delete-account')
  const userID = delete.dataset.userid
  delete.addEventListener("click", function() {
    fetch("/users/" + userID, {method: "DELETE"})
  })
}
