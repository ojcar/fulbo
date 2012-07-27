class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  def has_role?(rolename)
    self.roles.find_by_name(rolename) ? true : false
  end
end
