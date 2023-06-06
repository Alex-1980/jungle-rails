require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'Validation' do

    it 'should save user when all required fields are set correctly' do
      @user = User.new(name: 'Alex H', email: 'alex@alex.com', password: "12345alex", password_confirmation: "12345alex")
      @user.save
      expect(@user).to be_valid
    end

    it 'should not save if password and password_confirmation do not match' do
      @user = User.new(name: 'Alex H', email: 'alex@alex.com', password: "12345alex", password_confirmation: "67890alex")
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should provide an error message if password not set' do
      @user = User.new(name: 'Alex H', email: 'alex@alex.com', password: nil, password_confirmation: nil)
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should provide an error message if name not set' do
      @user = User.new(name: nil, email: 'alex@alex.com', password: "12345alex", password_confirmation: "12345alex")
      @user.save
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'should provide an error message if email not set' do
      @user = User.new(name: 'Alex H', email: nil, password: "12345alex", password_confirmation: "12345alex")
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should have a minimun password length' do
      @user = User.new(name: 'Alex H', email: 'alex@alex.com', password: "123", password_confirmation: "123")
      @user.save
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 5 characters)')
    end

    it 'should provide an error message if email is not unique' do
      @user_1 = User.new(name: 'Alex H', email: 'alex@alex.com', password: "12345alex", password_confirmation: "12345alex")
      @user_1.save
      @user_2 = User.new(name: 'Tim T', email: 'alex@alex.com', password: "67890alex", password_confirmation: "67890alex")
      @user_2.save
      expect(@user_2.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
    
    it 'should only log-in user with valid credentials' do
      @user = User.new(name: 'Alex H', email: 'alex@alex.com', password: "12345alex", password_confirmation: "12345alex")
      @user.save
      @user_logged_in = User.authenticate_with_credentials('alex@alex.com', "12345alex")
      expect(@user_logged_in).to_not eq(nil)
    end

    it 'should authenticate user if email contains trailing spaces' do
      @user = User.new(name: 'Alex H', email: 'alex@alex.com', password: "12345alex", password_confirmation: "12345alex")
      @user.save
      @user_logged_in = User.authenticate_with_credentials(' alex@alex.com ', "12345alex")
      expect(@user_logged_in).to_not eq(nil)
    end

    it 'should authenticate user if email in the wrong case' do
      @user = User.new(name: 'Alex H', email: 'ALEX@alex.com', password: "12345alex", password_confirmation: "12345alex")
      @user.save
      @user_logged_in = User.authenticate_with_credentials('alex@alex.com', "12345alex")
      expect(@user_logged_in).to_not eq(nil)
    end
  end
end
