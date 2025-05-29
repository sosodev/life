class RemoveTimeFinishedAndRenameTimeStartedToStartedAt < ActiveRecord::Migration[8.0]
  def change
    remove_column :tasks, :time_finished, :datetime
    rename_column :tasks, :time_started, :started_at
  end
end
