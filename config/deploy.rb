require "bundler/capistrano"
require "rvm/capistrano"

set :rvm_ruby_string, '1.9.3@tagr-server'

set :application, 'tagr-server'
set :repository,  'https://github.com/jonmiller/tagr-server.git'

set :scm, :git

role :web, 'tetyl.com'
role :app, 'tetyl.com'
role :db,  'tetyl.com', :primary => true

set :use_sudo, false
set :keep_releases, 5

set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"

ssh_options[:port] = 24242

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'

after 'deploy', 'deploy:cleanup'

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, roles: :app, except: { no_release: true } do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
end
