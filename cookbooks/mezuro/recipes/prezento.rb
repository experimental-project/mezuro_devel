# This recipe install Prezento
# 
# Prezento is the web interface for Mezuro.
# More about https://github.com/mezuro/prezento

# Configuring database files
PREZENTO_PATH = node[:mezuro][:prezento][:path]
cookbook_file "#{PREZENTO_PATH}/config/database.yml" do
	source '/prezento/database.yml'
	owner 'vagrant'
	group 'vagrant'
	mode 0644
end

# Install gems dependecies with bundle
execute 'bundle install --retry=3' do
	cwd PREZENTO_PATH
	not_if 'bundle check'
end

bash 'config and run kalibro_processor' do
	cwd PREZENTO_PATH
	code <<-EOH
	bundle exec rake db:create
	bundle exec rake db:setup
	bundle exec rails s -b 0.0.0.0 -d
	EOH
end