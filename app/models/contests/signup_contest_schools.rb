class SignupContestSchool < ActiveRecord::Base
  belongs_to :signup_contest
  belongs_to :school

  validate :signup_contest, :presence => true
  validate :school, :presence => true

  def score
    school.users.where(:profile_completed => true).count
  end
end