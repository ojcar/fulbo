class AddCommentsBody < ActiveRecord::Migration
  def self.up
      add_column :comments, :entry_id, :integer
      add_column :comments, :user_id, :integer
      add_column :comments, :body, :text
      add_index :comments, :entry_id
  end

  def self.down
    remove_column :comments, :entry_id
    remove_column :comments, :user_id
    remove_column :comments, :body
  end
end
