namespace :expired_announcement do
  task expired_task: :environment do
    tasks = Task.where('deadline < ?', Time.zone.today + 7).where.not(status: 2)
    users = []

    tasks.each do |task|
      users << task.user
    end

    users.uniq!

    users.each do |user|
      AnnounceTaskMailer.announce_task_mail(user).deliver
    end
  end
end
