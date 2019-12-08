# frozen_string_literal: true
module SessionsHelper
  def current_user
    current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def recommend_login
    redirect_to new_session_path unless current_user.present?
  end
end
