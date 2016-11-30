require 'rails_helper'

RSpec.describe Profile, type: :model do
	let(:user) {create(:user, :with_contacts)}
	let(:contact) {create(:contact, :with_phones, user: user)}
  let(:profile) {create(:profile, :with_contacts_join, user: user)}

  describe 'Profile Associations' do
  	it 'belongs to a user' do 
  		expect(profile.user).not_to be_blank
  	end
  	it 'has many contacts' do
  		expect(profile.contacts.count).not_to eq(0)
  	end
  end
end
