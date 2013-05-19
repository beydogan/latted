#############################################################
#	Application
#############################################################
load 'deploy/assets'
set :root_password, "123321-"
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
set :scm_passphrase, "123321-"
set :checkout, "export"

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

set :max_asset_age, 2 ## Set asset age in minutes to test modified date against.
#
#after "deploy:finalize_update", "deploy:assets:determine_modified_assets", "deploy:assets:conditionally_precompile"
#
#namespace :deploy do
#  namespace :assets do
#
#    desc "Figure out modified assets."
#    task :determine_modified_assets, :roles => assets_role, :except => { :no_release => true } do
#      set :updated_assets, capture("find #{latest_release}/app/assets -type d -name .git -prune -o -mmin -#{max_asset_age} -type f -print", :except => { :no_release => true }).split
#    end
#
#    desc "Remove callback for asset precompiling unless assets were updated in most recent git commit."
#    task :conditionally_precompile, :roles => assets_role, :except => { :no_release => true } do
#      if(updated_assets.empty?)
#        callback = callbacks[:after].find{|c| c.source == "deploy:assets:precompile" }
#        callbacks[:after].delete(callback)
#        logger.info("Skipping asset precompiling, no updated assets.")
#      else
#        logger.info("#{updated_assets.length} updated assets. Will precompile.")
#      end
#    end
#
#  end
#end