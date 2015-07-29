# config valid only for current version of Capistrano
lock '3.4.0'

set :repo_url, 'git@github.com:jibai31/smart_social_buffer.git'

# rbenv
set :rbenv_type, :system
set :rbenv_ruby, '2.2.2'
set :default_env, { path: "$PATH:/usr/local/rbenv/bin/:/usr/local/rbenv/shims/" }

# Passenger
set :passenger_restart_with_touch, true

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', '.env', '.htaccess')
set :linked_files, fetch(:linked_files, []).push('config/database.yml', '.env')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('public/system')

# Default value for keep_releases is 5
# set :keep_releases, 5

# ------------------------------------------------------
# Delayed::Job
# ------------------------------------------------------
# Number of delayed_job workers
# default value: 1
# set :delayed_job_workers, 2

# String to be prefixed to worker process names
# This feature allows a prefix name to be placed in front of the process.
# For example:  reports/delayed_job.0  instead of just delayed_job.0
# set :delayed_job_prefix, :reports

# Delayed_job queue or queues
# Set the --queue or --queues option to work from a particular queue.
# default value: nil
# set :delayed_job_queues, ['mailer','tracking']

# Specify different pools
# You can use this option multiple times to start different numbers of workers for different queues.
# default value: nil
# set :delayed_job_pools, {mailer: 2, tracking: 1, *: 2 }

# Set the roles where the delayed_job process should be started
# default value: :app
# set :delayed_job_roles, [:app, :background]

# Set the location of the delayed_job executable
# Can be relative to the release_path or absolute
# default value 'bin'
# set :delayed_job_bin_path, 'script' # for rails 3.x

# ------------------------------------------------------
# Tasks
# ------------------------------------------------------

namespace :deploy do

  # after :published, :restart do
  #   invoke 'delayed_job:restart'
  # end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
