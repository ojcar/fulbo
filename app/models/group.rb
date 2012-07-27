class Group < ActiveRecord::Base
  has_many :entries
  has_and_belongs_to_many :users
  belongs_to :country
  
  def has_group?(groupname)
    self.groups.find_by_name(groupname) ? true : false
  end
  
  def has_country?(countryid)
    self.countries.find(countryid) ? true : false
  end
  
  #def has_country?(countryid)
  #  self.groups.find(:first, :conditions => ["country_id = ?", countryid]) ? true : false
  #end
  
end
