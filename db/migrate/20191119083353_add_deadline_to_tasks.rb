class AddDeadlineToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, 'DATE NOT NULL DEFAULT CURRENT_TIMESTAMP'
  end
end
