require 'rails_helper'

RSpec.describe "Users API", type: :request do
  let!(:profile) { create(:profile) }
  let!(:users) { create_list(:user, 3, profile: profile) }
  let(:user_id) { users.first.id }

  describe "GET /api/v1/users" do
    it "returns all users" do
      get "/api/v1/users"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /api/v1/users/:id" do
    it "returns a single user" do
      get "/api/v1/users/#{user_id}"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["id"]).to eq(user_id)
    end
  end

  describe "POST /api/v1/users" do
    it "creates a user" do
      user_params = { email: "test@example.com", password: "password123", profile_id: profile.id }
      post "/api/v1/users", params: { user: user_params }

      expect(response).to have_http_status(201)
      expect(User.last.email).to eq("test@example.com")
    end
  end

  describe "PUT /api/v1/users/:id" do
    it "updates a user" do
      updated_params = { email: "updated@example.com" }
      put "/api/v1/users/#{user_id}", params: { user: updated_params }

      expect(response).to have_http_status(200)
      expect(User.find(user_id).email).to eq("updated@example.com")
    end
  end

  describe "DELETE /api/v1/users/:id" do
    it "deletes a user" do
      delete "/api/v1/users/#{user_id}"

      expect(response).to have_http_status(204)
      expect(User.exists?(user_id)).to be_falsey
    end
  end
end
