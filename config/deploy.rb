# This will be added later.
# task :production do
#   set :application, "igotfunk"
#   set :user, "yourusername"
#   set :domain, "igotfunk.com"
#   set :repository, "svn+ssh://#{user}@satyrs.site5.com/home/#{user}/repos/#{application}/trunk/"
#   set :deploy_to, "/home/#{user}/#{application}"
#   
#   role :app, domain
#   role :web, domain
#   role :db,  domain, :primary => true
# end

task :staging do
  set :application, "apollo"
  set :user, "igotfunk"
  set :domain, "igotfunk.com"
  set :repository, "git@github.com:artfulgeek/igotfunk.git"
  set :deploy_to, "/home/#{user}/staging/public"
  set :scm, :git
  
  role :app, domain
  role :web, domain
  role :db,  domain, :primary => true
end

# Necessary to run on Site5
set :use_sudo, false
set :group_writable, false

# Less releases, less space wasted
set :keep_releases, 2

# thanks to http://www.rubyrobot.org/article/deploying-rails-20-to-mongrel-with-capistrano-21
set :runner, nil

default_run_options[:pty] = true

desc "Restart the web server. Overrides the default task for Site5 use"
deploy.task :restart, :roles => :app do
  run "cd /home/#{user}; rm -rf public_html; ln -s #{current_path}/public ./public_html"
  run "skill -9 -u #{user} -c dispatch.fcgi"
  run "ln -s ~/staging/public ~/public_html/staging"
end

deploy.task :start do 
end 

task :after_update_code do
  #run "rm -rf /home/igotfunk/public_html/staging/apollo/current/config/database.yml"
  
  run "ln -nfs #{deploy_to}/#{shared_dir}/public/.htaccess #{release_path}/public/.htaccess"
end
