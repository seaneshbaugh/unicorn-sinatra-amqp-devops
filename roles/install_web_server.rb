name 'install_web_server'
description 'Install Web Server Role'
run_list(
  'recipe[yum::epel]',
  'recipe[install_packages]',
  'recipe[install_mysql_client]',
  'recipe[install_nginx]',
  'recipe[erlang::source]',
  'recipe[rabbitmq]'
)
