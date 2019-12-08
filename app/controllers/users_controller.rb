# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: '登録が完了しました'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
