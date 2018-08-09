require_relative "../rails_helper.rb"

describe "admin user creation", type: :feature do
  it "successfully signs up as an admin" do
    user_signup
    expect(current_path).to eq('/users/1')
    expect(page).to have_link("Manage Orders")
  end
end

describe "user show page", type: :feature do
  let(:harry) {User.create(name: "Harry Potter", email: "hp@hogwarts.com", password: "scar", phone_number: "1111111111")}
  let(:product) {Product.create(name: "Shiny shoes", price: 29.99, inventory: 200)}
  let(:dumbledore) {User.create(name: "Dumbledore", email: "dumbledore@email.com", password: "phoenix", phone_number: "1234567890")}

  it "does not allow a user to view page if not logged in" do
    page.set_rack_session(user_id: nil)
    visit '/users/1'
    expect(current_path).to eq('/')
  end

  it "contains link to create a new order" do
    page.set_rack_session(user_id: harry.id)
    visit user_path(harry)
    click_link("New Order")
    expect(current_path).to eq(new_user_order_path(harry))
  end

  it "allows user to edit and delete account" do
    page.set_rack_session(user_id: harry.id)
    visit user_path(harry)
    expect(page).to have_button("Delete Account")
    expect(page).to have_link("Edit Account")
  end

  it "does not allow standard users to delete products" do
    page.set_rack_session(user_id: harry.id)
    visit product_path(product)
    expect(current_path).to_not have_button("Delete Product")
  end

  it "allows admin users to edit and delete products" do
    page.set_rack_session(user_id: dumbledore.id)
    visit product_path(product)
    expect(page).to have_link("Edit Product")
    expect(page).to have_button("Delete Product")
  end
end
