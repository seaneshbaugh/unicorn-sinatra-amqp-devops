include_attribute 'commons'

gs_default = Chef::DataBagItem.load('global_settings', 'default')
env = Chef::DataBagItem.load('environments', node['chef_environment'])

default[:env][:application_url] = env['application_url']

default[:env][:smtp_address] = env['smtp_address']
default[:env][:smtp_port] = env['smtp_port']
default[:env][:smtp_domain] = env['smtp_domain']
default[:env][:smtp_authentication] = env['smtp_authentication']
default[:env][:smtp_user_name] = env['smtp_user_name']
default[:env][:smtp_password] = env['smtp_password']

default[:unicorn][:user] = node['commons']['deploy_user']
default[:unicorn][:worker_processes] = [node[:cpu][:total].to_i * 4, 8].min
default[:unicorn][:backlog] = 1024
default[:unicorn][:timeout] = 60
default[:unicorn][:preload_app] = true
default[:unicorn][:before_fork] = 'sleep 1'
default[:unicorn][:tcp_nodelay] = true
default[:unicorn][:tcp_nopush] = false
default[:unicorn][:tries] = 5
default[:unicorn][:delay] = 0.5
default[:unicorn][:accept_filter] = 'httpready'

default[:nginx][:worker_processes] = [node[:cpu][:total].to_i, 2].min
default[:nginx][:dir] = '/etc/nginx'
default[:nginx][:log_dir] = '/var/log/nginx'
