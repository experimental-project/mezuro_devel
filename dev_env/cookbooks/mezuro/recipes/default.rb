#
# Cookbook Name:: mezuro
# Recipe:: default
#
# Copyright 2015, Paulo Tada
#
# All rights reserved - Do Not Redistribute
#

# Including recipes dependencies
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

# Defining some usefull command
execute 'apt_update' do
	command 'apt-get update'
	action :nothing
end

execute 'apt_upgrade' do
	command 'apt-get upgrade'
	action :nothing
end
