require_relative "../rails_helper.rb"

describe "order creation", type: :feature do
  it "only allows users to access page if logged in" do
    page.set_rack_session(user_id: nil)
    visit "/users/1/orders/new"
    expect(current_path).to eq('/')
  end

  it "creates eligible orders after submission" do

  end
end

describe "orders index", type: :feature do
  it "only allows admin users to access page" do

  end

  it "allows admin users to fulfill order" do

  end
end

describe "orders show", type: :feature do
  it "only allows admin users or users who created the order to view" do

  end

  it "contains link to be edited or deleted" do

  end
end
