class RenameColumnInNotice < ActiveRecord::Migration[5.2]
  def change
    rename_column :notices, :tasks_id, :task_id
  end
end
