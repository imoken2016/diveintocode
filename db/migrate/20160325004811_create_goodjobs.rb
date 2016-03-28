class CreateGoodjobs < ActiveRecord::Migration
  def change
    create_table :goodjobs do |t|
      t.references :user
      t.references :task
      t.integer :number

      t.timestamps null: false
    end
  end
end
