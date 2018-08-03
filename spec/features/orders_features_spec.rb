require_relative "../rails_helper.rb"

describe "order creation", type: :feature do
  it "only allows users to access page if logged in" do
    page.set_rack_session(user_id: nil)
    visit "/users/1/orders/new"
    expect(current_path).to eq('/')
  end
end
