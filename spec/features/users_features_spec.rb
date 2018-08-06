require_relative "../rails_helper.rb"

describe "admin user creation", type: :feature do
  it "successfully signs up as an admin" do
    visit new_user_path
    fill_in("user[name]", with: "Walt Disney")
    fill_in("user[password]", with: "MickeyMouse")
    fill_in("user[phone_number]", with: "1234567890")
    fill_in("user[email]", with: "disney@gmail.com")
    check "user[admin]"
    click_button('Create User')

    expect(current_path).to eq('/users/admin/1')
    expect(page).to have_content("Welcome Admin User")
  end
end

describe "standard user show page", type: :feature do
  let(:harry) {User.create(name: "Harry Potter", email: "hp@hogwarts.com", password: "scar", phone_number: "1111111111")}

  it "does not allow a user to view page if not logged in" do
    page.set_rack_session(user_id: nil)
    visit '/users/1'
    expect(current_path).to eq('/')
  end

  it "contains link to create a new order" do

  end

  it "allows user to edit and delete account" do

  end

  it "does not allow users to edit products" do

  end
end
