set :application, "io.gd"
set :deploy_to,   "/var/www/#{application}" 

# production server
role :app,  application
role :web,  application
role :db,   application, :primary => true

# misc
set :use_sudo, false
ssh_options[:forward_agent] = true

# git config
set :git_path_prefix, "git@github.com:stevenwilkin"
set :repository, "#{git_path_prefix}/#{application}.git" 
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
#set :deploy_via, :remote_cache

# deploying to Passenger
namespace :deploy do
	desc "Restart Application"
    task :restart, :roles => :app do
	    run "touch #{current_path}/tmp/restart.txt"
	end
end
