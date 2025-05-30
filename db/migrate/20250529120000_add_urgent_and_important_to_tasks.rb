class AddUrgentAndImportantToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :urgent, :boolean, default: false, null: false
    add_column :tasks, :important, :boolean, default: false, null: false
  end
end
