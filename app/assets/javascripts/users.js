document.addEventListener("DOMContentLoaded", function() {
  const jumbotron = document.querySelector(".jumbotron")
  const userID = jumbotron.dataset.userid
  deleteButton(userID)
  phoneButton()
  submitForm(userID)
})

function deleteButton(userID) {
  let delButton = document.getElementById('delete-account')
  delButton.addEventListener("click", function() {
    fetch("/users/" + userID, {method: "DELETE"})
  })
}

function phoneButton() {
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
    var data = {label: "Phone Number: ", input: "phone-input"}
  } else {
    var data = {label: "Email: ", input: "email-input"}
  }
  form.innerHTML += template(data)
}

function submitForm(userID) {
  var forms = document.querySelectorAll("form")
  for(var form of forms) {
    form.addEventListener("submit", function(e) {
      e.preventDefault();
      fetch("/users/" + userID + ".json").then(resp => resp.json()).then(function(userResp) {
        updatePhone(userResp.phone_number)
      })
    })
  }
}

function getInput(form) {
  if(form.id === "phone-form") {
    let phoneInput = document.getElementById("phone-input").value
    let data = {phone_number: phoneInput}
  } else {
    let emailInput = document.getElementById("email-input").value
    let data = {email: emailInput}
  }
  let reqData = {
    method: "PATCH",
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(data)
  }
  return reqData
}

function updatePhoneOrEmail(info) {

}
