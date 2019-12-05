class CreateNoticeTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :notice_tasks do |t|
      t.references :user, foreign_key: true
      t.references :tasks, foreign_key: true

      t.timestamps
    end
  end
end
