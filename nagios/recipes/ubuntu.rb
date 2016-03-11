user "#{node[:nagios][:user]}" do
action :create
password 'nagios'
end

group "#{node[:nagios][:group]}" do
  members ['nagios', 'www-data']
end

execute 'install nagios-core' do
cwd node[:nagios][:opt]
command "wget #{node[:nagios][:ubuntu_core]};tar xzf nagios-4.1.1.tar.gz"
end

execute 'configure nagios' do
cwd node[:nagios][:ubuntu_nagios_dir]
command './configure --with-command-group=nagcmd;make all;make install;make install-init;make install-config;make install-commandmode'
end

template "#{node[:nagios][:nagios_conf]}" do
source 'nagios.conf.erb'
end

execute 'create directory' do 
command 'mkdir -p /usr/local/nagios/var/spool/checkresults;chmod 755 /usr/local/nagios/var/spool/checkresults;chown nagios:nagios /usr/local/nagios/var/spool/checkresults'
end

execute 'verify configuration' do
command '/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg'
end

execute 'Installing Nagios Plugins' do
cwd node[:nagios][:opt]
command "wget #{node[:nagios][:ubuntu_plugin]};tar xzf nagios-plugins-2.0.3.tar.gz"
end

execute 'Nagios plugin'do
cwd node[:nagios][:ubuntu_plugin_dir]
command './configure --with-nagios-user=nagios --with-nagios-group=nagios;make;make install'
end

execute 'configure' do 
command 'sudo htpasswd -s -c /usr/local/nagios/etc/htpasswd.users nagiosadmin;sudo a2enmod rewrite;sudo a2enmod cgi'
end

execute 'verify configuration' do
command '/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg'
end


service 'nagios' do
  action :start
end

execute 'start on system boot' do
	command 'ln -s /etc/init.d/nagios /etc/rcS.d/S99nagios'
end