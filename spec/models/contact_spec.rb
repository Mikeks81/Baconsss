require 'rails_helper'

RSpec.describe Contact, type: :model do
	let(:contact) {build(:contact, :with_phones)}

  describe "Contact validations" do
  	it 'is valid with first_name, phone_number and user ' do
  		expect(contact).to be_valid
  	end

  	it 'is invalid without first_name and error msg' do
  		contact = build(:contact_invalid_first_name)
  		expect(contact).not_to be_valid
  		expect(contact.errors[:first_name]).to include("can't be blank")
  	end

  	it 'is invalid without phones and error msg' do
  		contact = build(:contact)
  		expect(contact).not_to be_valid
  		expect(contact.errors[:phones]).to include("can't be blank")
  	end

  	it 'is invalid witout associated user' do
  		contact = build(:contact, :without_user)
  		expect(contact).not_to be_valid
  		expect(contact.errors[:user]).to include("must exist")
  	end
  end

  describe "Contact Associations" do
  	it 'belongs to user' do 
  		expect(contact.user.blank?).to eq(false)
  	end
  	it 'has many phones' do
  		expect(contact.phones.size).to eq(1)
  	end
  end
end
