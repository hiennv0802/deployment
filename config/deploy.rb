# config valid for current version and patch releases of Capistrano
lock "~> 3.13.0"

set :application, "deployment"
set :repo_url, "git@github.com:hiennv0802/deployment.git"
set :branch, :master
set :stage, :production
set :rails_env, :production
set :deploy_to, "/var/www/#{fetch(:application)}"
set :puma_state, "tmp/pids/puma.state"
set :puma_pid, "tmp/pids/puma.pid"

set :format, :pretty
set :keep_releases, 5
set :pty, true
set :keep_releases, 5
set :rvm_type, :user
set :settings, YAML.load_file("config/deploy/settings.yml")
set :linked_files, fetch(:linked_files, []).push(
  "config/database.yml", "config/application.yml", "config/master.key"
)
set :linked_dirs, fetch(:linked_dirs, []).push(
  "log", "tmp/pids", "tmp/cache", "tmp/sockets",
  "vendor/bundle", "public/system", "public/uploads"
)

namespace :deploy do
  desc "Initial Deploy"
  task :initial do
    on roles(:app) do
      before "deploy:restart", "puma:start"
      invoke "deploy"
    end
  end

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke "puma:restart"
    end
  end
  after  :finishing, :cleanup
  # after  :finishing, :restart
end

# namespace :deploy do
#   after :publishing, "deploy:restart"
#   after :finishing, "deploy:cleanup"
# end
