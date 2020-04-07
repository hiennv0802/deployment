set :user, fetch(:settings)["deployer"]
set :deploy_via, :remote_cache
set :conditionally_migrate, true
set :rails_env, "production"
set :hostip, fetch(:settings)["servers"]

role :app, fetch(:hostip)
role :web, fetch(:hostip)
role :db,  fetch(:hostip)

roles = %w(web app db)

fetch(:hostip).each do |hostip|
  server hostip, user: fetch(:user), port: fetch(:port), roles: roles
end
