class RenameTaskTitleToNameAndMakeNonNull < ActiveRecord::Migration[8.0]
  def change
    rename_column :tasks, :title, :name
    change_column_null :tasks, :name, false
  end
end
