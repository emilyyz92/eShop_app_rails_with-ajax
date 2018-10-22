document.addEventListener("DOMContentLoaded", function() {
  const jumbotron = document.querySelector(".jumbotron")
  const userID = jumbotron.dataset.userid
  deleteButton(userID)
  phoneButton(jumbotron)
})

function deleteButton(userID) {
  let delButton = document.getElementById('delete-account')
  delButton.addEventListener("click", function() {
    fetch("/users/" + userID, {method: "DELETE"})
  })
}

function phoneButton(jumbotron) {
  const addPhone = document.getElementById("add-phone")
  const editPhone = document.getElementById('edit-phone')
  const phoneForm = document.getElementById('phone-form')
  if (addPhone) {
    addPhone.addEventListener("click", function() {
      addForm(phoneForm)})
  } else {
    editPhone.addEventListener("click", function() {
      addForm(phoneForm) })
  }
}

function addForm(form) {
  var template = Handlebars.compile(
    document.getElementById("form-template").innerHTML)
  if (form.id === "phone-form") {
    var data = {label: "Phone Number: "}
  } else {
    var data = {label: "Email: "}
  }
  form.innerHTML += template(data)
}

function submitForm(userID) {
  var forms = document.querySelectorAll("form")
  for(var form of forms) {
    form.addEventListener("click", function(e) {
      e.preventDefault();
      fetch("/users/" + userID).then(resp => resp.json())
    })
  }
}
