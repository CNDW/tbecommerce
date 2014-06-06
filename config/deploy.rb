# config valid only for Capistrano 3.1
# lock '3.1.0'

# set :application, 'tbecommerce'
# set :repo_url, 'git@github.com:cndw/tbecommerce.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/home/rails/tbecommerce'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :application, 'tbecommerce'
set :deploy_user, 'spree'

set :use_sudo, false

set :scm, :git
set :repo_url, 'git@github.com:CNDW/tbecommerce.git'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/spree}

# what specs should be run before deployment is allowed to
# continue, see lib/capistrano/tasks/run_tests.cap
set :tests, []

set(:config_files, %w(
  nginx.conf
  database.example.yml
  log_rotation
  unicorn.rb
))

set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/nginx.conf"
  },
  {
    source: "log_rotation",
    link: "/etc/logrotate.d/#{fetch(:application)}"
  }
])

namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, "deploy:check_revision"
  # only allow a deploy with passing tests to deployed
  before :deploy, "deploy:run_tests"
  # compile assets locally then rsync
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
  after :finished, 'deploy:unicorn_restart'
end

