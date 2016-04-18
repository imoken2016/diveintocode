require 'rails_helper'

RSpec.describe SubmitRequestsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #approve" do
    it "returns http success" do
      get :approve
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #unapprove" do
    it "returns http success" do
      get :unapprove
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #approve_finish" do
    it "returns http success" do
      get :approve_finish
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #progress" do
    it "returns http success" do
      get :progress
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #inbox" do
    it "returns http success" do
      get :inbox
      expect(response).to have_http_status(:success)
    end
  end

end
