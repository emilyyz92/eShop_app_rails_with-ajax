document.addEventListener("DOMContentLoaded", function() {
  deleteButton()
  phoneButton()
  submitForm()
})

function getUserID() {
  const jumbotronDiv = document.getElementById("userShowBody")
  return jumbotronDiv.dataset.userid
}

function deleteButton() {
  let delButton = document.getElementById('delete-account')
  var userID = getUserID();
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

function submitForm() {
  var userID = getUserID();
  const divBody = document.getElementById("userShowBody")
  var forms = document.querySelectorAll("form")
  for(var form of forms) {
    form.addEventListener("submit", function(e) {
      e.preventDefault();
      var reqData = getInput(form)
      debugger;
      fetch("/api/v1/users/" + userID + ".json", reqData).then(
      resp => resp.json()).then(function(userResp) {
        updatePhoneOrEmail(divBody, form, userResp)
      })
    })
  }
}

function getInput(form) {
  //used in submitForm(); get input from the add/edit phone/email forms
  let dataBody
  if(form.id === "phone-form") {
    let phoneInput = document.getElementById("phone-input").value
    dataBody = {user: {phone_number: phoneInput}}
  } else {
    let emailInput = document.getElementById("email-input").value
    dataBody = {email: emailInput}
  }
  var reqData = {
    method: "PATCH",
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(dataBody)
  }
  return reqData
}

function updatePhoneOrEmail(divBody, form, userResp) {
  //replace with updated phone number
  if(form.id === "phone-form") {
    document.getElementById("p-phone-number").innerHTML = userResp.phone_number
    var add_phone = document.getElementById("add-phone")
    if(add_phone) {
      divBody.removeChild(add_phone)
    }
  } else {
    document.getElementById("p-email").innerHTML = userResp.email
  }
}
