set :application, "fulbo.net"
set :user, "ojcar"

set :local_repository, "svn+fulbossh://209.20.88.98/home/ojcar/repository/fulbo/fulbo"
set :repository, "file:///home/ojcar/repository/fulbo/fulbo"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

set :port, 30000

set :deploy_to, "/home/ojcar/public_html/fulbo.net/fulbo"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, application
role :web, application
role :db,  application , :primary => true

set :runner, user
after "deploy", "deploy:cleanup"
after "deploy:migrations", "deploy:cleanup"
