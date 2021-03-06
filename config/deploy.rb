# config valid only for current version of Capistrano
lock "3.8.1"

server "192.168.3.131", port: 22, rolse: [:web, :app, :db], primary: true

set :repo_url, "git@github.com:jmilam/cardinal.git"
set :application, "cardinal"
set :user, "itadmin"

set :use_sudo, false
set :deploy_via, :reomte_cache
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }

## Defaults:
set :scm,           :git
#set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
set :keep_releases, 5
set :assets_roles, [:web, :app]

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
