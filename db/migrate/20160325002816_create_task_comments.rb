class CreateTaskComments < ActiveRecord::Migration
  def change
    create_table :task_comments do |t|
      t.references :user
      t.references :task
      t.string :content

      t.timestamps null: false
    end
  end
end
