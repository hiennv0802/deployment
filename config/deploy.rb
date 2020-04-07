# config valid for current version and patch releases of Capistrano
lock "~> 3.12.1"

set :application, "deployment"
set :repo_url, "git@github.com:hiennv0802/deployment.git"
set :branch, :master
set :stage, :production
set :rails_env, :production
set :deploy_to, "/var/www/#{fetch(:application)}"

set :format, :pretty
set :keep_releases, 5
set :pty, true
set :linked_files, %w(config/database.yml config/application.yml)
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads)
set :keep_releases, 5
set :rvm_type, :user
set :settings, YAML.load_file("config/deploy/settings.yml")

namespace :deploy do
  after :publishing, "deploy:restart"
  after :finishing, "deploy:cleanup"
end
