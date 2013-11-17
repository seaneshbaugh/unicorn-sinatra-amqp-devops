set :chef_environments, %w(production)

default_run_options[:pty] = true

set :user, 'root'

set :use_sudo, false

set :install_packages, %w(rsync yum-utils)

set :chef_stream_output, true

namespace :bootstrap do
  desc 'Install base centos package for minimal install for IronChef requirements'
  task :os, except: { nochef: true }  do
    run "yum install #{install_packages.join(' ')} -y"
  end
end
