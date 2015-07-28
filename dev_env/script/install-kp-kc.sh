#!/bin/bash
# Script to install Kalibro Service and dependencies on Ubuntu 12.04.
# It may work on Debian 6 but this is untested.
#
# This script assumes a sane enviroment with at least the following
# depedencies already installed and configured:
# -sudo
#	-wget
#	-coreutils
# -RVM with Kalibro's Ruby version already installed (See rvm.io)
# -Postgresql
 
# Bash unofficial strict mode: http://www.redsymbol.net/articles/unofficial-bash-strict-mode/
set -eu
set -o pipefail
IFS=$'\n\t'

# Set script configuration
ANALIZO_VERSION='1.18.1' # Version >1.17.0 needs Ubuntu 13.10/Debian 7
 
# Kalibro dependencies (including Analizo)
sudo bash -c "echo \"deb http://analizo.org/download/ ./\" > /etc/apt/sources.list.d/analizo.list"
sudo bash -c "echo \"deb-src http://analizo.org/download/ ./\" >> /etc/apt/sources.list.d/analizo.list"
wget -O - http://analizo.org/download/signing-key.asc | sudo apt-key add -
sudo apt-get update -qq
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y analizo=${ANALIZO_VERSION} subversion git
 
# Kalibro Processor
# Cloning
git clone https://github.com/mezuro/kalibro_processor.git -b v0.5.0 kalibro_processor
# Given right permission for dir kalibro_processor
sudo chown -R $(whoami):$(whoami) kalibro_processor
pushd kalibro_processor # Equals 'cd' command
# Creating user role kalibro_processor
sudo psql -c "create role kalibro_processor with createdb login password 'kalibro_processor'" -U postgres
# Config the database files
sudo cp config/database.yml.postgresql_sample config/database.yml
sudo cp config/repositories.yml.sample config/repositories.yml
# RVM
rvm use 2.2.2
bundle install --retry=3
RAILS_ENV=local bundle exec rake db:setup db:migrate
# Uncomment if you wants to starts the server
# RAILS_ENV=local bundle exec rails s -p 8082 -d
RAILS_ENV=local bundle exec bin/delayed_job start
popd # Equals 'cd ..' command
 
# Kalibro Configurations
# Cloning
git clone https://github.com/mezuro/kalibro_configurations.git -b v0.1.0 kalibro_configurations
# Given right permission for dir kalibro_configurations
sudo chown -R $(whoami):$(whoami) kalibro_configurations
pushd kalibro_configurations
# Creating user role kalibro_configurations
sudo psql -c "create role kalibro_configurations with createdb login password 'kalibro_configurations'" -U postgres
# Config the database files
sudo cp config/database.yml.postgresql_sample config/database.yml
# RVM
rvm use 2.2.2
bundle install --retry=3
bundle exec rake db:setup db:migrate
# Uncomment if you wants to starts the server
# bundle exec rails s -p 8083 -d
popd

# Prezento
git clone https://github.com/mezuro/prezento.git -b v0.5.0 prezento
# Give right permission for dir prezento
sudo chown -R $(whoami):$(whoami) prezento
pushd prezento
# Config the database files
sudo cp config/database.yml.sample config/database.yml
# RVM
rvm use 2.2.2
bundle install
bundle exec rake db:create
bundle exec rake db:setup
bundle exec rails s -b 0.0.0.0 -d
popd
