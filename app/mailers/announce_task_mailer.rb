# frozen_string_literal: true
class AnnounceTaskMailer < ApplicationMailer
  def announce_task_mail(user)
    @user = user
    @tasks = @user.tasks.where('deadline < ?', Time.zone.today + 7).where.not(status: 2)

    mail to: @user.email, subject: '期限間近のタスクがあります！'
  end
end
