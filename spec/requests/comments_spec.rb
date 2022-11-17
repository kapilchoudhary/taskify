require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user)  { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }
  let!(:task) { create(:task, project_id: project.id, assignee_id: user.id, reporters_id: user.id) }
  let(:params) { { body: "This is a test comment"} }

  before do
    sign_in(user)
  end

  describe 'POST /projects/:project_id/comments' do
    it "returns http success" do
      post "/projects/#{project.id}/comments", params: { comment: params }
      expect(response).to redirect_to(project)
    end
  end

  describe 'POST /tasks/:task_id/comments' do
    it "returns http success" do
      post "/tasks/#{task.id}/comments", params: { comment: params }
      expect(response).to redirect_to(project_task_path(id: task.id, project_id: task.project_id ))
    end
  end
end