class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    @comment.save
    if @comment.commentable_type == "Project"
      redirect_to @commentable, notice: "Your comment was sucessfully posted."
    else
      redirect_to project_task_path(id: @commentable.id, project_id: @commentable.project_id ), notice: "Your comment was sucessfully posted."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
