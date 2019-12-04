class ApplicationController < ActionController::Base
  before_action :basic
  before_action :set_tasks, if: :logged_in?
  include SessionsHelper

  private
  def basic
    if Rails.env == "production"
      authenticate_or_request_with_http_basic do |name, password|
        name == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD']
      end
    end
  end

  def set_tasks
    @alert_tasks = current_user.tasks.where('deadline < ?', Time.zone.today - 10)
  end
end
