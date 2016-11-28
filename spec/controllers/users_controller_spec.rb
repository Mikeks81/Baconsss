require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) {create(:user)}
  before do
    sign_in user
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {id: user}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: {id: user}
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update" do
    it "returns http 302 redirect" do
      patch :update, params: {id: user, user: attributes_for(:user, email: "toubly@ex.com")}
      expect(response).to have_http_status(302)
    end

    it 'updates user email' do
      patch :update, params: {id: user, user: attributes_for(:user, email: "toubly@ex.com")}
      user.reload
      expect(user.email).to eq("toubly@ex.com")
    end
  end

  describe "DELETE #destroy" do
    it "returns http 302 redirect" do
      delete :destroy, params: {id: user}
      expect(response).to have_http_status(302)
    end

    it 'reduces User.all.count by -1' do
      expect {
        delete :destroy, params: {id: user}
      }.to change(User,:count).by(-1)
    end
  end

end
