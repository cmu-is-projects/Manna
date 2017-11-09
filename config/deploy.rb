require 'bundler/capistrano'
# require 'puma/capistrano'

server 'acacmanna.org', :web, :app, :db, primary: true

set :application, 'manna'
set :user, 'stephen'
set :group, 'stephen'
set :deploy_to, "/home/#{user}/apps/#{application}"

set :scm, 'git'
set :git_enable_submodules, 1
set :deploy_via, :remote_cache
set :repository, "git@github.com:cmu-is-projects/Manna.git"
set :branch, 'master'

set :use_sudo, false

# whenever configuration (for cron jobs)
# require 'whenever/capistrano'
# set :whenever_command, 'bundle exec whenever'

# share public/uploads
set :shared_children, shared_children + %w{public/uploads}

# allow password prompt
default_run_options[:pty] = true

# turn on key forwarding
ssh_options[:forward_agent] = true

# keep only the last 5 releases
after 'deploy', 'deploy:cleanup'
after 'deploy:restart', 'deploy:cleanup'

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :symlink_shared do
    run "ln -s /home/stephen/apps/manna/shared/settings.yml /home/stephen/apps/manna/releases/#{release_name}/config/"
  end
end

before "deploy:assets:precompile", "deploy:symlink_shared"

# before "deploy:restart", "deploy:symlink_shared"

# task :symlink_config, roles: :app do
#   run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
#   run "ln -nfs #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
# end
# after "deploy:finalize_update", "deploy:symlink_config"
