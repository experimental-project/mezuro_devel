#
# Cookbook Name:: mezuro
# Recipe:: default
#
# Copyright 2015, Paulo Tada
#
# More information about the project http://mezuro.org/
# If you want to contribute: https://github.com/mezuro

# Including recipes dependencies
include_recipe "postgresql::client"
include_recipe "postgresql::server"
include_recipe "rvm::system"
include_recipe "rvm::vagrant"

## Installing some packages dependecies for the env
package "build-essential"
package "vim"
package "curl"
package "git"
package "nodejs"
package "npm"
package "tmux"

# Defining some usefull command
execute 'apt_update' do
	command 'apt-get update'
	action :nothing
end

execute 'apt_upgrade' do
	command 'apt-get upgrade'
	action :nothing
end

template '/etc/postgresql/9.3/main/pg_hba.conf' do
	owner 'postgres'
	group 'postgres'
	mode '600'
	variables({
		users: 		node['mezuro']['postgresql']['users']
		})
	notifies :restart, 'service[postgresql]'
end

# Git submodules [init, update]
execute 'git submodules (init,update)' do
	cwd node[:mezuro][:shared]
	command "git submodule init && git submodule update"
end