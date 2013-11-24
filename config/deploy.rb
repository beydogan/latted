set :application, 'latted.me'
set :repo_url, 'git@github.com:beydogan/latted.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, "/var/www/latted.me"
set :scm, :git

set :rvm_type, :auto
set :rvm_ruby_version, '1.9.3-p448@latted'

role :app, "passenger@s.mehmet.pw"


namespace :db do
  task :db_config do
    on roles(:app) do
      execute "cp -f ~/database.yml #{release_path}/config/database.yml"
    end
  end
end


after "deploy:finishing", "db:db_config"

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      #run "touch #{current_path}/tmp/restart.txt"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
