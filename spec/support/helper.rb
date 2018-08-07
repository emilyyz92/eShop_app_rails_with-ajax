def order_helper
  let(:harry) {User.create(name: "Harry Potter", email: "hp@hogwarts.com", password: "scar", phone_number: "1111111111")}
  let(:order1) {Order.create(user_id: harry.id)}
  let(:headmaster) {User.create(name: "Dumbledore", email: "albus@hogwarts.com", password: "golden snitch", phone_number: "2222222222", admin: true)}
  let(:malfoy) {User.create(name: "Malfoy", email: "malfoy@hogwarts.com", password: "Dolby", phone_number: "3333333333")}
end
