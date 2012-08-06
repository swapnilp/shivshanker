CarrierWave.configure do |config|
  if Rails.env == "development"
    config.fog_credentials = {
      :provider => "local",
      :local_root => Rails.root
    }
    config.fog_directory  = "public"
  end
end