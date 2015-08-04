#
# Cookbook Name:: mezuro
# Attributes:: default
#
# Copyright 2015, Paulo Tada.
#

# For Vagrant usage
# This is the default shared folder of vagrant
# If you want to change, be sure to config this on Vagrantfile
default['mezuro']['shared'] = '/vagrant'

# Attributes for Analizo
default['mezuro']['analizo']['version'] = '1.18.1'

# Attributes for kalibro_processor
default['mezuro']['user']['kalibro_processor']		= 'kalibro_processor'
default['mezuro']['kalibro_processor']['path']		= "#{node[:mezuro][:shared]}/kalibro_processor"
default['mezuro']['kalibro_processor']['password']	= 'kalibro_processor'

# Attributes for kalibro_configurations
default['mezuro']['user']['kalibro_configurations']		= 'kalibro_configurations'
default['mezuro']['kalibro_configurations']['path']		= "#{node[:mezuro][:shared]}/kalibro_configurations"
default['mezuro']['kalibro_configurations']['password']	= 'kalibro_configurations'

# Attributes for prezento
default['mezuro']['prezento']['path']	= "#{node[:mezuro][:shared]}/prezento"

# All the users for PostgreSQL
default['mezuro']['postgresql']['users']	= ["kalibro_processor", "kalibro_configurations", "postgres"]
