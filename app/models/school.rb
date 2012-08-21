class School < ActiveRecord::Base
  has_many :athletes, :dependent => :destroy
  has_many :teams, :dependent => :destroy
  has_many :games, :through => :teams, :dependent => :destroy
  has_many :users, :through => :athletes

  validates :name, :presence => true
  validates :address, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip, :presence => true
  #validates :mascot, :presence => true
  #validates :primary_color, :presence => true
  #validates :secondary_color, :presence => true
  #validates :latlon, :presence => true
  validates :timezone, :presence => true

  def short_name
    name.gsub(/ High School$| High$| Magnet School$| School$| Institute$| Senior High School$| Junior Senior High School$/,"")
  end

  def cheerleader_ids
    sport = Sport.where(:name => "Cheer / Pep Squad").first
    cheerleader_teams = Team.where(:sport_id => sport.id, :school_id => id)
    Athlete.joins(:athlete_teams).where(:athlete_teams => {:team_id => cheerleader_teams.map(&:id)}).map(&:user_id)
  end

  def self.dump_to_json
    states = School.group(:state).select(:state).map(&:state)
    states.each do |state|
      file = File.new(Rails.root.join('db', 'seed_data', 'schools', "schools_#{state.downcase}.json"), "w")
      json = School.where(:state => state).to_json
      json = JSON.parse(json)
      json = JSON.pretty_generate(json)
      file.write(json)
    end
  end

  # load school latitude/longitude from json seed files
  def self.reload_latlong_from_json
    Dir.glob(Rails.root.join('db', 'seed_data', 'schools', '*.json')) do |filename|
      json = File.read(filename)
      data = MultiJson.load(json)

      School.transaction do
        data.each do |hash|
          s = School.find(hash['id'])
          s.latitude = hash['latitude']
          s.longitude = hash['longitude']
          s.save!
        end
      end
    end
  end

  # load school latitude/longitude from Yahoo Placefinder
  def self.reload_latlong_from_api
    conn = Faraday.new(:url => 'http://where.yahooapis.com') do |builder|
      builder.use Faraday::Request::UrlEncoded  # convert request params as "www-form-urlencoded"
      #builder.use Faraday::Response::Logger     # log the request to STDOUT
      builder.use Faraday::Adapter::NetHttp     # make http requests with Net::HTTP
    end

    School.where(:latitude => 0, :longitude => 0).find_in_batches do |batch|
      School.transaction do
        batch.each do |school|
          response = nil
          info = nil

          while response.nil? || info.nil?
            begin
              response = conn.get do |req|
                req.url '/geocode'
                req.params['appid'] = 'iVaQAX5a'
                req.params['flags'] = 'J'
                req.params['q'] = school.address + ", " + school.city + ", " + school.state + " " + school.zip
              end

              info = JSON.parse(response.body)
            rescue
              puts "help"
              response = nil
              info = nil
            end
          end
          
          if response.status == 200 && info['ResultSet']['Error'] == 0
            school.latitude = info['ResultSet']['Results'][0]['latitude']
            school.longitude = info['ResultSet']['Results'][0]['longitude']
            school.save!
          else
            logger.error 'could not find latlong for school id ' + school.id
          end
        end
      end
    end
  end

  # ElasticSearch integration
  include Tire::Model::Callbacks
  include Tire::Model::Search
  include Search::ReloadHelper

  tire do
    settings({
      :analysis => {
        :filter => Search::Filters.hs_name_filters,
        :analyzer => Search::Analyzers.hs_name_analyzers
      }
    })

    mapping do
      indexes :id, :type => 'integer', :index => :not_analyzed
      indexes :name, :type => 'string', :analyzer => :hs_name_analyzer
      indexes :address, :type => 'string', :index => :not_analyzed
      indexes :city, :type => 'string', :analyzer => :hs_name_analyzer
      indexes :state, :type => 'string', :index => :not_analyzed
      indexes :zip, :type => 'integer', :index => :not_analyzed
      indexes :location, :type => 'geo_point', :lat_lon => true
    end
  end

  def to_indexed_json
    {
      :id   => id,
      :name => name,
      :address => address,
      :city => city,
      :state => state,
      :zip => zip,
      :location => {
        :lat => latitude,
        :lon => longitude
      }
    }.to_json
  end
end
