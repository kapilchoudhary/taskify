# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_status, only: %i[user_tasks search_tasks]
  def index; end

  def user_tasks
    @user_tasks = current_user.assigned_tasks
  end

  def search_tasks
    @user_tasks = Task.tasks_filter(params.slice(:from, :to, :status, :search), current_user)

    respond_to do |format|
      format.html { render :user_tasks }
    end
  end

  private

  def set_status
    @status = Task::statuses
  end
end
