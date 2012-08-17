class Contest < ActiveRecord::Base
  attr_accessible :name, :starting, :ending, :contest_type

  SUBCLASSES = [:picture_contest]
  SUBCLASSES.each do |class_name|
    has_one class_name
  end

  has_many :contest_users, :dependent => :destroy
  has_many :contest_votes, :dependent => :destroy
  has_many :users, :through => :contest_users

  validates :name, :presence => true
  validates :starting, :presence => true
  validates :ending, :presence => true

  def self.active
    today = Time.zone.now
    where('starting <= ? AND ending > ? AND published = ?', today, today, true).order('end ASC')
  end

  def self.eligible? user
    Contest.active.select {|c| c.eligible? user}
  end

  def self.inactive
    today = Time.zone.now
    where('end < ?', today).order('end DESC')
  end

  def self.participating? user
    Contest.joins(:contest_users).where(:contest_users => {:user_id => user.id})
  end

  def self.preloaded
    Contest.all.tap do |contests|
      ActiveRecord::Associations::Preloader.new(contests, contests.map(&:contest_type).uniq).run
    end
  end

  def accepting_entries?
    today = Time.zone.now
    return (entry_end > today)
  end

  def currently_active?
    today = Time.zone.now
    return (starting <= today && ending > today)
  end

  def inactive
    today = Time.zone.now
    return ending < today
  end

  def eligible? user
    cu = contest_users.where(:user_id => user.id).first
    
    if cu.nil?
      ContestUser.transaction do
        cu = ContestUser.new
        cu.contest = self
        cu.user = user
        cu.save!
      end
    end

    return cu.eligible
  end

end
