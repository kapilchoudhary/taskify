# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index; end

  def all_task
    @tasks = Task.all
  end

  def show_your_task
    @user_task = current_user.assigned_tasks
  end
end
