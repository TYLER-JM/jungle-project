require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    let(:user) { User.new(first_name: "john", last_name: "doe", email: "john@mail.com", password: "123", password_confirmation: "123") }

    it "should be valid when passwords match" do
      expect(user).to be_valid
    end
    it "should be invalid when passwords don't match" do
      user.password = "122"
      expect(user).to_not be_valid
    end
    it "should be invalid when passwords is too short" do
      user.password = "1"
      user.password_confirmation = "1"
      expect(user).to_not be_valid
    end
    it "should be invalid when password confirmation is not present" do
      user.password_confirmation = nil
      expect(user).to_not be_valid
    end
    it "should be invalid when email is not present" do
      user.email = nil
      expect(user).to_not be_valid
    end
    it "should be invalid when first Name is not present" do
      user.first_name = nil
      expect(user).to_not be_valid
    end
    it "should be invalid when last Name is not present" do
      user.last_name = nil
      expect(user).to_not be_valid
    end
  end

  describe '.authenicate_with_credentials' do
    let(:user) { User.new(first_name: "john", last_name: "doe", email: "john@mail.com", password: "123", password_confirmation: "123") }

    it "should return truthy when password and email are good" do
      user.save!
      @new_login = User.authenticate_with_credentials("john@mail.com", "123")
      expect(@new_login).to be_truthy
    end
    it "should return truthy even when email contains leading or trailing whitespace" do
      user.save!
      @new_login = User.authenticate_with_credentials("     john@mail.com ", "123")
      expect(@new_login).to be_truthy
    end
    it "should return truthy even when email is cased differently" do
      user.save!
      @new_login = User.authenticate_with_credentials("JOHN@mail.com", "123")
      expect(@new_login).to be_truthy
    end
    it "should return nil when password and email aren't found in DB" do
      user.save!
      @new_login = User.authenticate_with_credentials("john@aol.com", "123")
      expect(@new_login).to be_nil
    end
  end
end
