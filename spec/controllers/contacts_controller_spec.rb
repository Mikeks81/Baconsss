require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let(:contact){create(:contact, :with_phones)}
  let(:phones_attributes){attributes_for(:phone, contact_id: contact)}

  before do
    sign_in contact.user
  end

  describe "POST #create" do
    it "returns http 302 redirect" do
      post :create, params: {user_id: contact.user_id,
                             contact: attributes_for(:contact,
                             phones_attributes: {"0" => phones_attributes})}
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {user_id: contact.user_id, id: contact}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: {user_id: contact.user_id, id: contact}
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update" do
    it "returns http 302 redirect" do
      patch :update, params: {user_id: contact.user_id,
                             id: contact,
                             contact: attributes_for(:contact, 
                             first_name: "Boogy", 
                             last_name: "Ooogy",
                             phones_attributes: {"0" => phones_attributes})}

      expect(response).to have_http_status(302)
    end

    it 'expects first name and last name to update' do
      patch :update, params: {user_id: contact.user_id,
                             id: contact,
                             contact: attributes_for(:contact, 
                             first_name: "Boogy", 
                             last_name: "Ooogy",
                             phones_attributes: {"0" => phones_attributes})}
      contact.reload
      expect(contact.first_name).to eq("Boogy")
      expect(contact.last_name).to eq("Ooogy")
    end
  end

  describe "DELETE #destroy" do
    it "returns http 302 redirect" do
      delete :destroy, params: {user_id: contact.user_id, id: contact}
      expect(response).to have_http_status(302)
    end
  end

end
