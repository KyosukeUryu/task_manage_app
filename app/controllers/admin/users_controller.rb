class Admin::UsersController < ApplicationController
  before_action :admin_only
  def index
    @users = User.order(created_at: :desc)
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def admin_only
    redirect_to root_path unless current_user.try(:admin?)
  end
end
