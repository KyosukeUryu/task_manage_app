class AddConstraintsToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :name, :string, null: false, limit: 30
    change_column :tasks, :description, :text, null: false
  end
end
