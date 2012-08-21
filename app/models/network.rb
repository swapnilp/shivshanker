class Network < ActiveRecord::Base
  attr_accessible :name
  
  KINDS = [:school_network, :school_sport_network, :sport_network]
  KINDS.each do |class_name|
    has_one class_name
  end

  has_and_belongs_to_many :users
  
  validate :name, :presence => true
end
