set :application, "nanolooploop"
set :repository,  "git@github.com:halfbyte/Nanolooploop.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "headflash.com"                          # Your HTTP server, Apache/etc
role :app, "headflash.com"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :user, "jan"

set :deploy_to, "/home/jan/rackapps/#{application}"
set :run_method, :run

after 'deploy:update_code', :set_symlinks

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

desc "setting symlinks"
task :set_symlinks do
  run "ln -s #{shared_path}/config/mongodb.yml #{release_path}/config/mongodb.yml"
end



namespace :deploy do
  task :start do ; end
  task :migrate do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end