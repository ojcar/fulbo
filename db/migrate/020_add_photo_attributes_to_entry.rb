class AddPhotoAttributesToEntry < ActiveRecord::Migration
  def self.up
  	add_column :entries, :parent_id, :integer
    add_column :entries, :content_type, :string
    add_column :entries, :filename, :string    
    add_column :entries, :thumbnail, :string 
    add_column :entries, :size, :integer
    add_column :entries, :width, :integer
    add_column :entries, :height, :integer
    remove_column :entries, :image
  end

  def self.down
 	remove_column :entries, :parent_id
    remove_column :entries, :content_type
    remove_column :entries, :filename   
    remove_column :entries, :thumbnail 
    remove_column :entries, :size
    remove_column :entries, :width
    remove_column :entries, :height
  end
end
