user node[:nagios][:user] do
action :create
end

group node[:nagios][:group] do
  members ['nagios', 'apache']
end

directory node[:nagios][:directory] do
  action :create
end

execute 'nagios-core' do
cwd node[:nagios][:directory]
	command "wget #{node[:nagios][:centos_core]};wget #{node[:nagios][:centos_plugin]};tar zxf nagios-4.0.1.tar.gz;tar zxf nagios-plugins-1.5.tar.gz'
end

execute 'installation' do
	cwd 'node[:nagios][:cent_nagios_dir]' 
	command './configure --with-command-group=nagcmd;make all;make install;make install-init;make install-commandmode;make install-config;make install-webconf; htpasswd -s -c /usr/local/nagios/etc/htpasswd.users nagiosadmin'
end

service 'httpd' do
  action [ :enable, :restart ]
end

execute 'Compile and Install Nagios Plugin' do
	cwd node[:nagios][:cent_plugin_dir]
	command './configure --with-nagios-user=nagios --with-nagios-group=nagios;make;make install'
end

execute 'verify' do
	command '/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg'
end

execute 'Add Nagios Services to System Startup' do 
	command 'chkconfig --add nagios;chkconfig --level 35 nagios on;chkconfig --add httpd;chkconfig --level 35 httpd on'
end

service 'nagios' do 
	action :start
end
	