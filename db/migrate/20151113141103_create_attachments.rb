class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name
      t.integer :task_id
      t.string :file
      t.string :content_type
    end
  end
end
