module GroupRepresenter
  include Roar::Representer::JSON::HAL

  property :id
  property :name
  property :user_id


  link :self do
    group_url self
  end
end
