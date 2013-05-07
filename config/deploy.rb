#############################################################
#	Application
#############################################################
load 'deploy/assets'

set :application, "app.mehmet.pw"
set :deploy_to, "/var/www/#{application}"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
set :use_sudo, true

#############################################################
#	Servers
#############################################################

set :user, "root"
set :domain, "s.mehmet.pw"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	Subversion
#############################################################

set :repository,  "git@s.mehmet.pw:social.git"
set :svn_username, "git"
set :svn_password, "123321-"
set :checkout, "export"
load 'deploy/assets'

#############################################################
#	Passenger
#############################################################

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after :deploy, "passenger:restart"