name 'setup_app_server'
description 'Setup Application Server Role'
run_list(
  'recipe[setup_deployer]',
  'recipe[setup_sinatra_app]'
)
