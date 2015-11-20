class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :name
      t.integer :position
      t.boolean :done, default: false
      t.date :deadline

      t.timestamps
    end
  end
end
