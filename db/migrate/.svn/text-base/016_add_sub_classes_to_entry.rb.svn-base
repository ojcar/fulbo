class AddSubClassesToEntry < ActiveRecord::Migration
  def self.up
    # Adds SubClasses to Entries
    add_column :entries, :type, :string
    
    # attributes for type=Text
    # - none -
    
    # attributes for type=Link
    add_column :entries, :url, :string
    
    # attributes for type=Photo
    add_column :entries, :image, :string
    
    #attributes for type=Quote
    add_column :entries, :source, :string
    
    #attributes for type=Video
    # add_column :entries, :video_address, :string
    
  end

  def self.down
    remove_column :entries, :type
    remove_column :entries, :url
    remove_column :entries, :image
    remove_column :entries, :source
  end
end
