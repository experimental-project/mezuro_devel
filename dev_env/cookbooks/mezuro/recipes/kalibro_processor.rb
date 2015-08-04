# This recipe install Kalibro Processor
# 
# Kalibro Processor is a source code analysis web service.
# More about https://github.com/mezuro/kalibro_processor

# Cloning repository to default shared folder of vagrant
SHARED_FOLDER = node[:mezuro][:shared]
git "#{SHARED_FOLDER}/kalibro_processor" do
	repository node[:mezuro][:kalibro_processor][:repo]
	reference node[:mezuro][:kalibro_processor][:version]
end

# Creating kalibro_processor role
# The current process of creating role is:
# 	drop if exist <role>
# 	create role <role> ...
# TODO: do only one command that creates the role if not exists
PROCESSOR_USR = node[:mezuro][:user][:kalibro_processor]
PROCESSOR_PWD = node[:mezuro][:kalibro_processor][:password]

execute 'drop role kalibro_processor' do
	command "psql -c \"drop role if exists #{PROCESSOR_USR}\" -U postgres"
end

execute 'create role kalibro_processor' do
	command "psql -c \"create role #{PROCESSOR_USR} with createdb login password '#{PROCESSOR_PWD}'\" -U postgres"
end
