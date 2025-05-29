class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.references :parent, null: true, foreign_key: { to_table: :tasks }
      t.integer :recur_after
      t.integer :estimate
      t.integer :time_taken
      t.timestamp :finished_at

      t.timestamps
    end
  end
end
