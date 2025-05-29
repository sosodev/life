class ReplaceTimeTakenWithTimeStartedAndFinished < ActiveRecord::Migration[8.0]
  def change
    remove_column :tasks, :time_taken, :integer
    add_column :tasks, :time_started, :datetime
    add_column :tasks, :time_finished, :datetime
  end
end
