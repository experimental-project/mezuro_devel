# This recipe install Kalibro Processor
# 
# Kalibro Processor is a source code analysis web service.
# More about https://github.com/mezuro/kalibro_processor

# Cloning repository to default shared folder of vagrant
SHARED_FOLDER = node[:mezuro][:shared]
git "#{SHARED_FOLDER}/kalibro_processor" do
	repository node['mezuro']['kalibro_processor']['repo']
	reference node['mezuro']['kalibro_processor']['version']
end

# Creating kalibro_processor role
PROCESSOR_PWD = node[:mezuro][:kalibro_processor][:password]
execute 'role kalibro_processor' do
	command "psql -c \"create role kalibro_processor with createdb login password '#{PROCESSOR_PWD}'\" -U postgres"
end