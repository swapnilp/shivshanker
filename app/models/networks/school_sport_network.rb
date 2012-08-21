class SchoolSportNetwork < ActiveRecord::Base
  attr_accessible :network, :school, :sport,:network_type

  belongs_to :network
  belongs_to :school
  belongs_to :sport

  validate :network, :presence => true
  validate :school, :presence => true
  validate :sport, :presence => true
  validate :network_type, :presence => true

  def self.find_or_create school, sport, network_type
    n = Network.joins(:school_sport_network).where(:school_sport_networks => {
      :school_id => school.id, :sport_id => sport.id, :network_type => network_type
    }).first

    if n.nil?
      SchoolSportNetwork.transaction do
        ssn = SchoolSportNetwork.create!(
          :school => school,
          :sport => sport,
          :network_type => network_type,
          :network => Network.create!(:name => "#{school.name} #{sport.name} Network"))

        n = ssn.network
      end
    end

    return n
  end
end