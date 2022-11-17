require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let(:user)  { create(:user) }
  let!(:project) {create(:project, user_id: user.id)}
  let(:params) { { title:"Project title test", description:"test description", status: 1, user_id: user.id} }

  before do
    sign_in(user)
  end

  describe 'GET /projects' do
    it "returns http success" do
      get "/projects.json"
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json.first).to have_key("title")
      expect(json.first["title"]).to eq(project.title)
    end
  end

  describe 'GET /projects/:id' do
    it "returns http success" do
      get "/projects/#{project.id}.json"
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json).to have_key("title")
      expect(json["title"]).to eq(project.title)
    end
  end

  describe 'POST /projects' do
    it "returns http success" do
      post "/projects.json", params: { project: params }
      expect(response).to have_http_status(201)
      json = JSON.parse(response.body)
      expect(json).to have_key("title")
      expect(json["title"]).to eq("Project title test")
    end
  end

  describe 'PUT /projects/:id' do
    it 'return http success' do
      put "/projects/#{project.id}.json", params: { project: params }
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json).to have_key("title")
      expect(json["title"]).to eq("Project title test")
    end
  end

  describe 'DELETE /projects/:id' do
    it 'return http failure' do
      delete "/projects/#{project.id}"
      expect(response).to redirect_to(projects_url)
    end
  end
end