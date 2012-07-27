class CreateCountriesUsersJoin < ActiveRecord::Migration
  def self.up
    create_table :countries_users, :id => false do |t|
      t.column :country_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :countries_users
  end
end
