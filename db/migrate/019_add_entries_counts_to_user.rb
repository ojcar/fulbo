class AddEntriesCountsToUser < ActiveRecord::Migration
  def self.up
  	add_column :users, :entries_count, :integer, :null => false, :default => 0
  end

  def self.down
  	remove_column :users, :entries_count
  end
end
