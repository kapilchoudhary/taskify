# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index; end

  def user_tasks
    @user_tasks = current_user.assigned_tasks
  end
end
