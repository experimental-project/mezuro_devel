# This recipe install Analizo
# 
# Analizo is a multi-language source code analysis suite
# More about http://www.analizo.org/

ANALIZO_VERSION = node[:mezuro][:analizo][:version]

execute 'add_repo_key' do
	command 'wget -O - http://www.analizo.org/download/signing-key.asc | apt-key add -'
	action :nothing
end

cookbook_file '/etc/apt/sources.list.d/analizo.list' do
	owner 'root'
	group 'root'
	mode 0644
	notifies :run, 'execute[add_repo_key]', :immediately
	notifies :run, 'execute[apt_update]', :immediately
end

execute 'install analizo' do
	command "DEBIAN_FRONTEND=noninteractive apt-get install -y analizo=#{ANALIZO_VERSION} subversion git"
end