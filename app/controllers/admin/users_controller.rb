class Admin::UsersController < ApplicationController
  before_action :admin_only
  before_action :set_user, only: %i[show edit update destroy]
  def index
    @users = User.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: '新規ユーザーを作成しました'
    else
      render :new
    end
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

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
