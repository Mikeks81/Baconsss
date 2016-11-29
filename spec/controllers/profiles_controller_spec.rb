require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
	let(:user) {create(:user, :with_contacts)}
	let(:contact) {create(:contact, :with_phones, user: user)}
  	let(:profile) {create(:profile, user: user, contacts:[contact])}
  	before do 
  		sign_in user
  	end

	describe 'POST #create' do
		it 'increases Profile count by 1' do
			expect {
				post :create, params: {user_id: user,
									   profile: attributes_for(:profile)}
			}.to change(Profile, :count).by(1)
		end
		it 'has HTTP 302 redirect' do
			post :create, params: {user_id: user,
								   profile: attributes_for(:profile)}
			expect(response).to have_http_status(302)
		end
	end

	describe 'PATCH #update' do
		it 'updates profile params' do 
			patch :update, params: {user_id: user,
									id: profile,
								    profile: attributes_for(:profile,
								    response_time: 34)}
			profile.reload
			expect(profile.response_time).to eq(34)			
		end
		it 'has HTTP 302 redirect' do
			patch :update, params: {user_id: user,
									id: profile,
								    profile: attributes_for(:profile)}
			expect(response).to have_http_status(302)
		end	
	end

	describe 'DELETE #destroy' do
		it 'decreases Profile count by -1' do
			profile
			expect{
				delete :destroy, params: {user_id: user, id: profile}
			}.to change(Profile,:count).by(-1)
		end

		it 'has HTTP status 302 redirect' do
			delete :destroy, params: {user_id: user, id: profile}
			expect(response).to have_http_status(302)
		end
	end
end
