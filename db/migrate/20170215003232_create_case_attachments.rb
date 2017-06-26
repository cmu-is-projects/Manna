class CreateCaseAttachments < ActiveRecord::Migration
  def change
    create_table :case_attachments do |t|
      t.integer :case_id
      t.integer :attachment_id

      t.timestamps null: false
    end
  end
end
