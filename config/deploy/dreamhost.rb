load 'config/_shared_deploy'

# set :repository, "file:///mnt/developer/mysportsbeat.git"
# set :local_repository, "ssh://developer@dev.sportsbeat.com/~/mysportsbeat.git"
set :deploy_to, '/mnt/sportsbeat/dev.sportsbeat.com'
set :deploy_via, :remote_cache
set :user, 'sportsbeat'
set :rails_env, 'dreamhost'

server "dev.sportsbeat.com", :app, :web, :db, :primary => true

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "if [ -f '#{current_path}/tmp/pids/rainbows.pid' ]; then kill -USR2 `cat #{current_path}/tmp/pids/rainbows.pid`; fi"
  end
end
