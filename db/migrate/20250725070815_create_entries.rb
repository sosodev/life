class CreateEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :entries do |t|
      t.references :journal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
