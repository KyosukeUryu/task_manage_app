class AddReadColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :read, :boolean, default: false
  end
end
