require_relative "../rails_helper.rb"

describe "product", type: :feature do
  order_helper
  it "allows admin users to successfully create a product" do
    page.set_rack_session(user_id: headmaster.id)
    visit new_product_path
    create_product
    expect(current_path).to eq('/products/1')
  end

  it "does not allow non-user or standard user to create product" do
    page.set_rack_session(user_id: nil)
    visit new_product_path
    expect(current_path).to eq(products_path)
  end

  it "does allows admin users to edit and delete product" do
    page.set_rack_session(user_id: headmaster.id)
    visit products_path
    click_link('The Elder Wand')
    expect(page).to have_button("Edit Product")
    click_link("Delete Product")
    expect(current_path).to eq(products_path)
  end

  it "admin can successfully edit a product" do
    page.set_rack_session(user_id: headmaster.id)
    visit product_path(product)
    fill_in('Price', with: '10999.98')
    click_link('Edit Product')
    expect(current_path).to eq(product_path(product))
    expect(product.price).to eq(10999.98)
  end

  it "shows admin users all orders of the product on its show page" do
    page.set_rack_session(user_id: headmaster.id)
    visit product_path(product)
    expect(page).to have_content("Order")
  end

  it "shows standard users details of the product" do
  end
end
