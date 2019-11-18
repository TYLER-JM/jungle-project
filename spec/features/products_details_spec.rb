require 'rails_helper'

RSpec.feature "ProductsDetails", type: :feature, js: true do

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

  scenario "They see one product" do
    # ACT
    visit root_path

    # click_on "Details"
    @one_product = first(".product")
    within(@one_product) do
      click_on("Details")
      # sleep 1
      page.should have_content
      puts page.html
      # save_screenshot
    end

    # DEBUG / VERIFY
    # expect(page).to have_css "article.product", count: 10
  end

end
