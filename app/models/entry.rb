class Entry < ActiveRecord::Base
  acts_as_voteable
  acts_as_flaggable
  acts_as_taggable
  belongs_to :user, :counter_cache => true
  belongs_to :category
  belongs_to :group
  has_many :comments
  validates_length_of :title, :within => 4..255
    
  def before_create
    @attributes['permalink'] = title.downcase.gsub(/\s+/, '_').gsub(/[^a-zA-z0-9_]+/, '')
  end
  
  def to_param
    "#{id}-#{permalink}"
  end
  
  protected
  def flagged(flag, flag_count)
    # add code here to what happens when flag reaches a certain flag_count
  end
end

class Texto < Entry
	validates_length_of :body, :maximum => 10000
end

class Link < Entry
	validates_length_of :url, :maximum => 10000
end

class Photo < Entry
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :max_size => 500.kilobytes,
                 :resize_to => '320x200>',
                 :thumbnails => { :thumb => '100x100>' },
                 :path_prefix => 'public/usrupload'
  validates_length_of :body, :maximum => 10000
  validates_as_attachment
end

class Quote < Entry
	validates_length_of :body, :maximum => 10000
end

# class Video < Entry
# end
