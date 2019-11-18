require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "should be valid when passwords match" do
      @user = User.new(first_name: "john", last_name: "doe", email: "john@mail.com", password: "123", password_confirmation: "123")
      expect(@user).to be_valid
    end
    it "should be invalid when passwords don't match" do
      @user = User.new(first_name: "john", last_name: "doe", email: "john@mail.com", password: "123", password_confirmation: "133")
      expect(@user).to_not be_valid
    end
    it "should be invalid when passwords is too short" do
      @user = User.new(first_name: "john", last_name: "doe", email: "john@mail.com", password: "1", password_confirmation: "1")
      expect(@user).to_not be_valid
    end
    it "should be invalid when password confirmation is not present" do
      @user = User.new(first_name: "john", last_name: "doe", email: "john@mail.com", password: "1", password_confirmation: nil)
      expect(@user).to_not be_valid
    end
    it "should be invalid when email is not present" do
      @user = User.new(first_name: "john", last_name: "doe", email: nil, password: "123", password_confirmation: "123")
      expect(@user).to_not be_valid
    end
    it "should be invalid when first Name is not present" do
      @user = User.new(first_name: nil, last_name: "doe", email: "john@mail.com", password: "123", password_confirmation: "123")
      expect(@user).to_not be_valid
    end
    it "should be invalid when last Name is not present" do
      @user = User.new(first_name: "john", last_name: nil, email: "john@mail.com", password: "123", password_confirmation: "123")
      expect(@user).to_not be_valid
    end
  end

  describe '.authenicate_with_credentials' do
    it "should return truthy when password and email are good" do
      @user = User.new(first_name: "john", last_name: "doe", email: "john@mail.com", password: "123", password_confirmation: "123")
      @user.save!

      @new_login = User.authenticate_with_credentials("john@mail.com", "123")
      expect(@new_login).to be_truthy
    end
    it "should return truthy even when email contains leading or trailing whitespace" do
      @user = User.new(first_name: "john", last_name: "doe", email: "john@mail.com", password: "123", password_confirmation: "123")
      @user.save!

      @new_login = User.authenticate_with_credentials("     john@mail.com ", "123")
      expect(@new_login).to be_truthy
    end
    it "should return truthy even when email is cased differently" do
      @user = User.new(first_name: "john", last_name: "doe", email: "joHN@mail.com", password: "123", password_confirmation: "123")
      @user.save!

      @new_login = User.authenticate_with_credentials("john@mail.com", "123")
      expect(@new_login).to be_truthy
    end
    it "should return nil when password and email aren't found in DB" do
      @user = User.new(first_name: "john", last_name: "doe", email: "john@mail.com", password: "123", password_confirmation: "123")
      @user.save!

      @new_login = User.authenticate_with_credentials("john@aol.com", "123")
      expect(@new_login).to be_nil
    end
  end
end
