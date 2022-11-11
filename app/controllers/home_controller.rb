class HomeController < ApplicationController
  def index
    @user_task = Task.all.where(assignee_id:current_user.id)
  end

  def show_all_task
    @tasks = Task.all
  end
end
