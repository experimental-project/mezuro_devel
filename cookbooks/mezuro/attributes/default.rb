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

# Attributes for kalibro_processor
default['mezuro']['user']['kalibro_processor']		= 'kalibro_processor'
default['mezuro']['kalibro_processor']['repo']		= 'https://github.com/mezuro/kalibro_processor.git'
default['mezuro']['kalibro_processor']['path']		= '#{SHARED_FOLDER}/kalibro_processor'
default['mezuro']['kalibro_processor']['password']	= 'kalibro_processor'
default['mezuro']['kalibro_processor']['version']	= 'v0.9.0'

# Attributes for kalibro_configurations
default['mezuro']['user']['kalibro_configurations']		= 'kalibro_configurations'
default['mezuro']['kalibro_configurations']['repo']		= 'https://github.com/mezuro/kalibro_configurations.git'
default['mezuro']['kalibro_configurations']['path']		= '#{SHARED_FOLDER}/kalibro_configurations'
default['mezuro']['kalibro_configurations']['password']	= 'kalibro_configurations'
default['mezuro']['kalibro_configurations']['password'] = 'v1.0.0'

# All the users for PostgreSQL
default['mezuro']['postgresql']['users']	= ["kalibro_processor", "kalibro_configurations", "postgres"]
