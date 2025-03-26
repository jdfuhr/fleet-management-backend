require 'rails_helper'

RSpec.describe "Profiles API", type: :request do
  let!(:profiles) { create_list(:profile, 3) }
  let(:profile_id) { profiles.first.id }

  describe "GET /api/v1/profiles" do
    it "returns all profiles" do
      get "/api/v1/profiles"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /api/v1/profiles/:id" do
    it "returns a single profile" do
      get "/api/v1/profiles/#{profile_id}"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["id"]).to eq(profile_id)
    end
  end

  describe "POST /api/v1/profiles" do
    it "creates a profile" do
      profile_params = { name: "Manager", permissions: ["view_reports"] }
      post "/api/v1/profiles", params: { profile: profile_params }

      expect(response).to have_http_status(201)
      expect(Profile.last.name).to eq("Manager")
    end
  end

  describe "PUT /api/v1/profiles/:id" do
    it "updates a profile" do
      updated_params = { name: "Updated Profile" }
      put "/api/v1/profiles/#{profile_id}", params: { profile: updated_params }

      expect(response).to have_http_status(200)
      expect(Profile.find(profile_id).name).to eq("Updated Profile")
    end
  end

  describe "DELETE /api/v1/profiles/:id" do
    it "deletes a profile" do
      delete "/api/v1/profiles/#{profile_id}"

      expect(response).to have_http_status(204)
      expect(Profile.exists?(profile_id)).to be_falsey
    end
  end
end
