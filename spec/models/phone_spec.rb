require 'rails_helper'

RSpec.describe Phone, type: :model do
	let(:phone) {build(:phone)}
	let(:invalid_phone) {build(:phone, :without_phone_number)}
	let(:user_phone) {build(:phone, :with_user)}
	let(:contact_phone) {build(:phone, :with_contact)}
	
  describe 'Phone Validations' do
  	it 'is valid with phone_number' do 
  		expect(phone).to be_valid
  	end

  	it 'is invalid without phone_number' do
  		expect(invalid_phone).not_to be_valid
  	end
  end

  describe 'Phone Associations' do 
  	it 'belongs to a user' do
  		expect(user_phone.user.blank?).to eq(false)
  	end

  	it 'belongs to a contact' do 
  		expect(contact_phone.contact.blank?).to eq(false)
  	end
  end
end
