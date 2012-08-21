require "likable"
require "search"
require "geo"

class User < ActiveRecord::Base
  extend Role::Helpers
  include Likable

  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :current_school_id, :profile_picture, :birthdate, :gender

  has_many :athletes, :dependent => :destroy
  has_many :athlete_teams, :through => :athletes
  has_many :schools, :through => :athletes
  has_many :sports, :through => :teams
  has_many :teams, :through => :athlete_teams
  has_many :teammates, :through => :teams, :source => :users, :uniq => true
  has_many :galleries, :as => :owner, :dependent => :destroy
  has_many :pictures, :as => :owner, :dependent => :destroy
  has_many :posts, :as => :author, :dependent => :destroy
  has_and_belongs_to_many :networks
  has_roles :admin, :alumnus, :athlete, :fan, :staff

  after_create :create_default_galleries

  def create_default_galleries
    Gallery.transaction do
      g = Gallery.new
      g.creator = self
      g.owner = self
      g.name = "My Pictures"
      g.save!

      g = Gallery.new
      g.creator = self
      g.owner = self
      g.name = "Beat Pictures"
      g.save!
    end
  end

  def current_athletes
    athletes.joins(:athlete_teams).where(:athlete_teams => {:season_id => Season.current.id})
  end

  def current_teams
    teams.where(:athlete_teams => {:season_id => Season.current.id})
  end

  def display_name
    first_name + " " + last_name
  end

  def location
    if self.athlete?
      a = athletes.order("final_year desc").first
      if a
        return { :latitude => a.school.latitude, :longitude => a.school.longitude }
      end
    end

    city = Geo.city current_sign_in_ip
    if city
      return { :latitude => city.latitude, :longitude => city.longitude }
    end

    # if the user's location cannot be determined, use the location of SportsBeat
    return { :latitude => 33.670765, :longitude => -117.866477 }
  end

  include Tire::Model::Callbacks
  include Tire::Model::Search
  include Search::ReloadHelper
  tire do
    settings({
      :analysis => {
        :filter => Search::Filters.user_filters,
        :analyzer => Search::Analyzers.user_analyzers
      }
    })

    mapping do
      indexes :id, :type => "integer"
      indexes :name, :type => "string", :analyzer => :user_name_analyzer
      indexes :email, :type => "string", :analyzer => :user_name_analyzer
      indexes :role, :type => "string", :index => :not_analyzed
      indexes :location, :type => "geo_point", :lat_lon => true
    end
  end

  def to_indexed_json
    loc = self.location

    {
      :id   => id,
      :name => display_name,
      :email => email,
      :role => roles.map(&:name),
      :location => {
        :lat => loc[:latitude],
        :lon => loc[:longitude]
      }
    }.to_json
  end
end
