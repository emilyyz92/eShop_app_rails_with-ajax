document.addEventListener("DOMContentLoaded", function() {
  const jumbotron = document.getElementById("userShowBody")
  const userID = jumbotron.dataset.userid
  deleteButton(userID)
  phoneButton()
  submitForm(jumbotron, userID)
})

function deleteButton(userID) {
  let delButton = document.getElementById('delete-account')
  delButton.addEventListener("click", function() {
    fetch("/users/" + userID, {method: "DELETE"})
  })
}

function phoneButton() {
  //add event listener to all buttons
  const addPhone = document.getElementById("add-phone")
  const editPhone = document.getElementById('edit-phone')
  const editEmail = document.getElementById('edit-email')
  const phoneForm = document.getElementById('phone-form')
  const emailForm = document.getElementById('email-form')
  if(addPhone) {
    addPhone.addEventListener("click", function() {addForm(phoneForm)})
  } else {
    editPhone.addEventListener("click", function() {addForm(phoneForm)})
  }
  editEmail.addEventListener("click", function() {addForm(emailForm)})
}

function addForm(form) {
  //from phoneButton(); add form after clicking on add or edit phone button
  var template = Handlebars.compile(
    document.getElementById("form-template").innerHTML)
  if (form.id === "phone-form") {
    var data = {label: "Phone Number: ", input: "phone-input"}
  } else {
    var data = {label: "Email: ", input: "email-input"}
  }
  form.innerHTML += template(data)
}

function submitForm(jumbotron, userID) {
  var forms = document.querySelectorAll("form")
  for(var form of forms) {
    form.addEventListener("submit", function(e) {
      e.preventDefault();
      fetch("/users/" + userID + ".json", getInput(form)).then(
      resp => resp.json()).then(function(userResp) {
        updatePhoneOrEmail(jumbotron, form, userResp)
      })
    })
  }
}

function getInput(form) {
  //used in submitForm(); get input from the add/edit phone/email forms
  let dataBody
  if(form.id === "phone-form") {
    let phoneInput = document.getElementById("phone-input").value
    dataBody = {phone_number: phoneInput}
  } else {
    let emailInput = document.getElementById("email-input").value
    dataBody = {email: emailInput}
  }
  let reqData = {
    method: "PATCH",
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(dataBody)
  }
  return reqData
}

function updatePhoneOrEmail(jumbotron, form, userResp) {
  //replace with updated phone number
  if(form.id === "phone-form") {
    document.getElementById("p-phone-number").innerHTML = userResp.phone_number
    var add_phone = document.getElementById("add-phone")
    if(add_phone) {
      jumbotron.removeChild(add_phone)
    }
  } else {
    document.getElementById("p-email").innerHTML = userResp.email
  }
}
