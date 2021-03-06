set :user, 'adminosl'
set :group, 'adminosl'
set :domain, 'railsapps1.osl.ull.es'
set :project, 'LibreCMS'
set :application, 'LibreCMS'
set :applicationdir, "/var/rails/#{application}"

# Configuracion de control de versiones
# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
set :repository,  "http://svn.osl.ull.es/LibreCMS/tags/release-0.0.9.2"

# Roles (servers)
role :app, "railsapps1.osl.ull.es"
role :web, "railsapps1.osl.ull.es"
role :db,  "railsapps1.osl.ull.es", :primary => true

# Deploy config
# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, applicationdir
set :deploy_via, :export

# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
ssh_options[:keys] = %w(~/.ssh/id_rsa)            # If you are using ssh_keys
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false   # On DreamHost's shared hosts, sudo can't be used to restart the app

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :start do
  end

  task :stop do
  end

  desc "Link shared files"
  task :before_symlink do
#    run "rm -drf #{release_path}/public/attached" #Not remove public/attached please!
    run "ln -s #{shared_path}/attached #{release_path}/public/attached"
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -s #{shared_path}/config/twitter_oauth.yml #{release_path}/config/twitter_oauth.yml"
    run "ln -s #{shared_path}/staticImages #{release_path}/public/staticImages"
  end
end
