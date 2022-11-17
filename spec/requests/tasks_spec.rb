require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user)  { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }
  let!(:task) { create(:task, project_id: project.id, assignee_id: user.id, reporters_id: user.id) }
  let(:params) { { title:"Project title test", content:"test description", status: 1, project_id: project.id, assignee_id: user.id, reporters_id: user.id } }

  before do
    sign_in(user)
  end

  describe 'GET /projects/:project_id/tasks' do
    it "returns http success" do
      get "/projects/#{project.id}/tasks.json"
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json.first).to have_key("title")
      expect(json.first["title"]).to eq(task.title)
    end
  end

  describe 'GET /projects/:project_id/tasks/:id' do
    it "returns http success" do
      get "/projects/#{project.id}/tasks/#{task.id}.json"
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json).to have_key("title")
      expect(json["title"]).to eq(task.title)
    end
  end

  describe 'POST /projects/:project_id/tasks' do
    it "returns http success" do
      post "/projects/#{project.id}/tasks.json", params: { task: params }
      expect(response).to have_http_status(201)
      json = JSON.parse(response.body)
      expect(json).to have_key("title")
      expect(json["title"]).to eq("Project title test")
    end
  end

  describe 'PUT /projects/:project_id/tasks/:id' do
    it "returns http success" do
      put "/projects/#{project.id}/tasks/#{task.id}.json", params: { task: params }
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json).to have_key("title")
      expect(json["title"]).to eq("Project title test")
    end
  end

  describe 'DELETE /projects/:project_id/tasks/:id' do
    it "returns http success" do
      delete "/projects/#{project.id}/tasks/#{task.id}.json"
      expect(response).to have_http_status(204)
    end
  end
end