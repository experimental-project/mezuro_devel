# This recipe install Kalibro Processor
# 
# Kalibro Processor is a source code analysis web service.
# More about https://github.com/mezuro/kalibro_processor

# Creating kalibro_processor role
# The current process of creating role is:
# 	drop if exist <role>
# 	create role <role> ...
# TODO: do only one command that creates the role if not exists
PROCESSOR_USR = node[:mezuro][:user][:kalibro_processor]
PROCESSOR_PWD = node[:mezuro][:kalibro_processor][:password]

# BUG: this will break if processor is already running
execute 'drop role kalibro_processor' do
	command "psql -c \"drop role if exists #{PROCESSOR_USR}\" -U postgres"
end

execute 'create role kalibro_processor' do
	command "psql -c \"create role #{PROCESSOR_USR} with createdb login password '#{PROCESSOR_PWD}'\" -U postgres"
end

# Configuring database files
PROCESSOR_PATH = node[:mezuro][:kalibro_processor][:path]
cookbook_file "#{PROCESSOR_PATH}/config/database.yml" do
	source '/kalibro_processor/database.yml'
	owner 'vagrant'
	group 'vagrant'
	mode 0644
end
cookbook_file "#{PROCESSOR_PATH}/config/repositories.yml" do
	source '/kalibro_processor/repositories.yml'
	owner 'vagrant'
	group 'vagrant'
	mode 0644
end

# Install gems dependecies with bundle
execute 'bundle install --retry=3' do
	cwd PROCESSOR_PATH
	not_if 'bundle check'
end

# This will create all the configuration files with
# 	defaults for Ubuntu and initialize your database.
bash 'config and run kalibro_processor' do
	cwd PROCESSOR_PATH
	code <<-EOH
	RAILS_ENV=local bundle exec rake db:setup db:migrate
	EOH
end