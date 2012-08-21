class SportNetwork < ActiveRecord::Base
  attr_accessible :network, :sport, :network_type

  belongs_to :network
  belongs_to :sport

  validate :network, :presence => true
  validate :sport, :presence => true
  validate :network_type, :presence => true

  def self.find_or_create sport, network_type
    n = Network.joins(:sport_network).where(:sport_networks => {
      :sport_id => sport.id, :network_type => network_type
    }).first

    if n.nil?
      SportNetwork.transaction do
        sn = SportNetwork.create!(
          :sport => sport,
          :network_type => network_type,
          :network => Network.create!(:name => "#{sport.name} Network"))

        n = sn.network
      end
    end

    return n
  end
end