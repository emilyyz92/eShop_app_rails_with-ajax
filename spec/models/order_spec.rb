require 'rails_helper'
RSpec.describe Order, type: :model do
  let(:user) {
    User.create(
      name: "Moana",
      password: "Heihei",
      email: "moanna@gmail.com",
      phone_number: "3334445555"
    )
  }

  let(:product) {
    Product.create(
      name: "Hawaiian Lei",
      price: 7.99,
      inventory: 5
    )
  }

  let(:order) {
    Order.create(
      user_id: user.id
    )
  }

  it "can return total price of the order" do
    2.times do
      order.items << Item.create(order_id: order.id, product_id: product_id)
    end
    expect(order.order_total_price).to eq(15.98)
  end

  it "knows the user who created it" do

  end

  it "reduces inventory level of the products from the order at creation" do
  end
end
