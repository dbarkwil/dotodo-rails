class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.datetime :due_date
      t.datetime :completion_date
      t.string :label
      t.boolean :sync

      t.timestamps
    end
  end
end
