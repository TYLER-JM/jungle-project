require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  before :each do
    @user = User.new(first_name: "john", last_name: "doe", email: "john@mail.com", password: "123", password_confirmation: "123")
    @user.save!
  end
  scenario "The user can login" do
    # ACT
    visit root_path

    click_on 'Login'
    fill_in 'email', with: 'john@mail.com'
    fill_in 'password', with: '123'
    
    click_on 'Submit'
    expect(page).to have_text 'john@mail.com'


  end
end
