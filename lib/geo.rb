require 'geoip'
require 'forwardable'
require 'singleton'

class Geo < GeoIP
  include Singleton
  extend SingleForwardable

  def_delegators :instance, *GeoIP.instance_methods(false)
  
  def initialize
    super(Rails.root.join('db', 'GeoIPCity.dat'))
  end

  def self.users_by_country_and_region
    countries = {}

    incrementRegion = lambda do |country, region|
      countries[country] ||= {}
      countries[country][region] ||= 0
      countries[country][region] += 1
    end

    User.where("email not like '%@sportsbeat.com'").find_each do |u|
      if u.school_id
        state = u.school.state.upcase
        incrementRegion.call "United States", state
      else
        ip = u.current_sign_in_ip || u.last_sign_in_ip

        city = Geo.city(ip)
        if city && city.region_name
          incrementRegion.call city.country_name, city.region_name
        end
      end
    end

    return countries
  end
end
