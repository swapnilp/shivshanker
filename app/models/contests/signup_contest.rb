class SignupContest < Contest
  attr_accessible :contest
  
  belongs_to :contest
  has_many :entries, :class_name => "SignupContestSchool", :dependent => :destroy
end