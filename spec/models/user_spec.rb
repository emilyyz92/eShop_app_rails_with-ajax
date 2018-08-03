require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user1) {
    User.create(
      name: "Moana"
      password: "Heihei"
      email: "moanna@gmail.com"
      phone_number: "3334445555"
    )
  }

  let (:admin) {
    User.create(
      name: "Hermione G"
      password: "Ron"
      email: "hermione@hogwarts.com"
      phone_number: "5678901234"
      admin: true
    )
  }

  let(:user2) {
    User.create(
      name: "fake email"
      password: "fake"
      email: "fake@123"
      phone_number: "0000000000"
    )
  }


  it "is valid with a name, email, password and phone number" do
    expect(user1).to be_valid
  end

  it "defaults to admin" do
    expect(user.admin).to eq(false)
  end

  it "is valid with an admin user" do
    expect(admin).to be_valid
  end

  it "is invalid without a proper email address" do
    expect(user2).not_to be_valid
  end
end
