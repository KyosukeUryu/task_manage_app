class RenameNoticeTasksToNotices < ActiveRecord::Migration[5.2]
  def change
    rename_table :notice_tasks, :notices
  end
end
