class AddCountryToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :country_id, :integer
  end

  def self.down
    remove_column :groups, :country_id
  end
end
