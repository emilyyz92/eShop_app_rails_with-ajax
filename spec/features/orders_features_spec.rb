require_relative "../rails_helper.rb"

describe "order creation", type: :feature do
  it "only allows users to access page if logged in" do
    page.set_rack_session(user_id: nil)
    visit "/users/1/orders/new"
    expect(current_path).to eq('/')
  end

  it "creates eligible orders after submission" do
    page.set_rack_session(user_id: 1)
    visit "/users/1/orders/new"
    check "order[product_ids][1]", select("1", from: "order[product_ids][1][count]")
    check "order[product_ids][3]", select("2", from: "order[product_ids][3][count]")
    click_button "Create Order"
    expect(current_path).to eq('/users/1/orders/1')
  end
end

describe "orders index", type: :feature do
  it "only allows admin users to access page" do
    @minnie = User.create(
      name: "Minnie",
      password: "password",
      email: "minnie@disney.com",
      phone: "9999999999"
      )
    page.set_rack_session(user_id: @minnie.id)
    expect(content).to have_content("You don't have access")
  end

  it "links to order show page" do
    click_button "Fulfill Order #1"

  end
end

describe "orders show", type: :feature do
  it "only allows admin users or users who created the order to view" do

  end

  it "contains link to be edited or deleted" do

  end

  it "allows admin user to fulfill order" do

  end

  it "does not allow standard user to fulfill order" do

  end

end
