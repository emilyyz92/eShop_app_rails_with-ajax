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

describe "user show page", type: :feature do
  it "does not allow a user to view page if not logged in" do

  end
