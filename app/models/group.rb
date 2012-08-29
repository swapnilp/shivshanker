class Group < ActiveRecord::Base
  attr_accessible :name, :users_id

  validates :name, :presence => true
  validates :users_id, :presence => true
  
end
