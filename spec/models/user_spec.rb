require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User Validation" do
  	let(:user) { build(:user)}
  	let(:invalid_user) { build(:user, email: "")}
  	let(:invalid_user_password) { build(:user, password: "")}
  	let(:invalid_user_password_conf) { build(:user, password_confirmation: "")}

  	it 'is valid with email' do
  		expect(user).to be_valid
  	end

  	it 'is invalid without email and have error message' do
  		expect(invalid_user).not_to be_valid
  		expect(invalid_user.errors[:email]).to include("can't be blank")
  	end

  	it 'is invalid without password and have error message' do
  		expect(invalid_user_password).not_to be_valid
  		expect(invalid_user_password.errors[:password]).to include("can't be blank")
  	end

  	it 'is invalid without password_confirmation and have error message' do
  		expect(invalid_user_password_conf).not_to be_valid
  		expect(invalid_user_password_conf.errors[:password_confirmation]).to include("doesn't match Password")
  	end

  	it 'is invalid if duplicate email' do
  		create(:user, email: "this@self.com")
  		user = build(:user, email: "this@self.com")
  		user.valid?
  		expect(user.errors[:email]).to include("has already been taken")
  	end
  end

  describe "User Associations" do
  	let(:user) { create(:user, :with_contacts)}

  	it 'has many contacts' do
  		expect(user.contacts.count).to eq(1)
  	end
  	it 'has many phones' do
  		expect(user.phones.count).to eq(1)
  	end
  end
end
