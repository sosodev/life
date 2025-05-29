class AddUniqueConstraintToTaskListName < ActiveRecord::Migration[8.0]
  def change
    change_column_null :task_lists, :name, false
    add_index :task_lists, :name, unique: true
  end
end
