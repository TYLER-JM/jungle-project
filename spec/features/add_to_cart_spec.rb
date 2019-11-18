require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "The cart shows 1 item" do
    # ACT
    visit root_path

    @one_product = first(".product")
    within(@one_product) do
      click_on "Add"
      # page.should have_content
    end
    expect(page).to have_text 'My Cart (1)'
    # save_screenshot
  end
end
