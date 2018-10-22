document.addEventListener("DOMContentLoaded", function() {
  const jumbotron = document.querySelector(".jumbotron")
  const userID = jumbotron.dataset.userid
  deleteButton(userID)
  editPhoneButton(jumbotron)
})

function deleteButton(userID) {
  let delButton = document.getElementById('delete-account')
  delButton.addEventListener("click", function() {
    fetch("/users/" + userID, {method: "DELETE"})
  })
}

function PhoneButton(jumbotron) {
  const addPhone = document.getElementById("add-phone")
  const editPhone = document.getElementById('edit-phone')
  if (addPhone) {
    addPhone.addEventListener("click", function() {
      addPhoneForm(jumbotron, addPhone)})
  } else {
    editPhone.addEventListener("click", function() {
      addPhoneForm(jumbotron, editPhone) })
  }
}

function addPhoneForm(jumbotron, phone) {
  var form = document.createElement("form")
  var input = document.createElement("input")
  var label = document.createElement("label")
  var submit = document.createElement("input")
  input.type = "text"
  submit.type = "submit"
  label.innerHTML = "Phone Number"
  form.appendChild(label)
  form.appendChild(input)
  jumbotron.insertBefore(form, phone)
}
