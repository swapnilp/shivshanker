class SchoolNetwork < ActiveRecord::Base
  attr_accessible :network, :school, :network_type

  belongs_to :network
  belongs_to :school

  validate :network, :presence => true
  validate :school, :presence => true
  validate :network_type, :presence => true

  def self.find_or_create school, network_type
    n = Network.joins(:school_network).where(:school_networks => {
      :school_id => school.id, :network_type => network_type
    }).first

    if n.nil?
      SchoolNetwork.transaction do
        sn = SchoolNetwork.create!(
          :school => school,
          :network_type => network_type,
          :network => Network.create!(:name => "#{school.name} Network"))

        n = sn.network
      end
    end

    return n
  end
end