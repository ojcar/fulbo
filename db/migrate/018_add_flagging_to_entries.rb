class AddFlaggingToEntries < ActiveRecord::Migration
  def self.up
     create_table :flags, :force => true do |t|
       t.column :flag, :string, :default => ""
       t.column :comment, :string, :default => ""
       t.column :created_at, :datetime, :null => false
       t.column :flaggable_id, :integer, :default => 0, :null => false
       t.column :flaggable_type, :string, :limit => 15, :default => "", :null => false
       t.column :user_id, :integer, :default => 0, :null => false
   end

   add_index :flags, ["user_id"], :name => "fk_flags_user"
  end

  def self.down
    drop_table :flags
  end
end
