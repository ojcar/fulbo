class CreateGroupsUsersJoin < ActiveRecord::Migration
  def self.up
    create_table :groups_users, :id => false do |t|
      t.column :group_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :groups_users
  end
end
