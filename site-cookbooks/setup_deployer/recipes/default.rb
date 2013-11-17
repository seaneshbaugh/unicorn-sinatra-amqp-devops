deploy_user = node['commons']['deploy_user']
deploy_home = node['commons']['deploy_home']

group deploy_user do
  action :create
end

user deploy_user do
  supports manage_home: true
  comment 'Deploy User'
  gid deploy_user
  home deploy_home
  password '$1$oo8mbpqY$gDTvuvfBUulOWmkgIetET1' # clickhere1234
end

sudoer_path = "/etc/sudoers.d/#{deploy_user}"
bash "create sudoers for #{deploy_user}" do
  user 'root'
  code <<-EOH
    touch #{sudoer_path}
    echo "#{deploy_user} ALL=(ALL) NOPASSWD: ALL" > #{sudoer_path}
    chmod 440 #{sudoer_path}
  EOH
  not_if { ::File.exists?(sudoer_path) }
end

directory "#{deploy_home}/.ssh" do
  owner deploy_user
  group deploy_user
  mode 0700
  action :create
end

cookbook_file "#{deploy_home}/.ssh/authorized_keys" do
  source 'authorized_keys'
  owner deploy_user
  group deploy_user
  mode 0600
  action :create
end

cookbook_file "#{deploy_home}/.bash_profile" do
  source '.bash_profile'
  owner deploy_user
  group deploy_user
  mode 0644
  action :create
end

template "#{deploy_home}/.bashrc" do
  source 'bashrc.erb'
  owner deploy_user
  group deploy_user
  mode 0644
  action :create
end

