if Rails.env == "development"
  $redis = Redis.new(:host => 'localhost', :port => 6379)
end