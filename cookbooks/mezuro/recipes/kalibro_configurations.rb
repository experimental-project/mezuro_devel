# This recipe install Kalibro Configurations
# 
# Kalibro Configurations is a source code analysis configuration web service.
# More about https://github.com/mezuro/kalibro_configurations

# Creating kalibro_configurations role
# The current process of creating role is:
# 	drop if exist <role>
# 	create role <role> ...
# TODO: do only one command that creates the role if not exists
CONFIGURATIONS_USR = node[:mezuro][:user][:kalibro_configurations]
CONFIGURATIONS_PWD = node[:mezuro][:kalibro_configurations][:password]

execute 'drop role kalibro_configurations' do
	command "psql -c \"drop role if exists #{CONFIGURATIONS_USR}\" -U postgres"
end

execute 'create role kalibro_configurations' do
	command "psql -c \"create role #{CONFIGURATIONS_USR} with createdb login password '#{CONFIGURATIONS_PWD}'\" -U postgres"
end

# Configuring database files
CONFIGURATIONS_PATH = node[:mezuro][:kalibro_configurations][:path]
cookbook_file "#{CONFIGURATIONS_PATH}/config/database.yml" do
	source '/kalibro_configurations/database.yml'
	owner 'vagrant'
	group 'vagrant'
	mode 0644
end

# Install gems dependecies with bundle
execute 'bundle install --retry=3' do
	cwd CONFIGURATIONS_PATH
	not_if 'bundle check'
end

# This will create all the configuration files with
# 	defaults for Ubuntu and initialize your database.
bash 'config and run kalibro_configurations' do
	cwd CONFIGURATIONS_PATH
	code <<-EOH
	bundle exec rake db:setup db:migrate
	bundle exec rails s -p 8083 -d
	EOH
end