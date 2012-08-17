class PictureContest < ActiveRecord::Base
  attr_accessible :contest
  
  belongs_to :contest
  has_many :entries, :class_name => "PictureContestEntry", :dependent => :destroy
end