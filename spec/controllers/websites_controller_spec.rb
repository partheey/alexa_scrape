require 'rails_helper'

RSpec.describe WebsitesController, type: :controller do
  let (:user) { FactoryGirl.create(:user) }
  let (:website1) { FactoryGirl.create(:website)}
  let (:website2) { FactoryGirl.create(:website, user: user)}

  describe "GET #index" do
    it "should redirect_to login page if the user is not signed in" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end

    it "returns http success" do
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should render index template" do
      sign_in user
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "returns http success" do
      sign_in website1.user
      get :show, params: {id: website1.id}
      expect(response).to have_http_status(:success)
    end

    it "should render show page" do
      sign_in website1.user
      get :show, params: {id: website1.id}
      expect(response).to render_template :show
    end
  end

  describe "POST #create" do
    it "returns http success" do
      sign_in user
      post :create, params: { address: 'http://google.com' }
      expect(response).to have_http_status(:success)
    end

    it "should render template index" do
      sign_in user
      post :create, params: { address: 'http://redpanthers.co' }
      expect(response).to render_template :index
    end

    it "should increase the website count by 1" do
      sign_in user
      expect{
        post :create, params: { address: 'http://gmail.com' }
      }.to change{Website.count}.by(1)
    end
  end

  describe "POST #create" do
    it "should render index and have http success" do
      sign_in website1.user
      delete :destroy, params: { id: website1.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template :index
    end

    it "should reduce the website count by 1" do
      sign_in website2.user
      expect{
        delete :destroy, params: { id: website2.id }
      }.to change{Website.count}.by(-1)
    end
  end
end
