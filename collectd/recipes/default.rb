#
# Cookbook Name:: collectd
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'wget'
execute 'collectd installation' do
	cwd '/tmp'
	command "wget http://collectd.org/files/collectd-5.5.0.tar.gz"
end
execute 'unzip the colletcd' do
	cwd '/tmp'
	command "tar -xvf collectd-5.5.0.tar.gz"
end
# execute 'Going to collectd folder' do
# 	command 'cd collectd-5.5.0'
# end
execute 'Running the configuration file' do
	cwd '/tmp/collectd-5.5.0'
	command "./configure"
end
execute 'installing all files' do
	cwd '/tmp/collectd-5.5.0'
	command "make all install"
end
template '/opt/collectd/etc/collectd.conf' do
  source 'collectd.conf.erb'
end
execute 'Running collectd services' do
	cwd '/opt/collectd/sbin'
	command "./collectd -C /opt/collectd/etc/collectd.conf"
end
