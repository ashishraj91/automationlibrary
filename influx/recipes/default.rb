#
# Cookbook Name:: influx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
if node[:platform] == 'ubuntu'

	apt_repository 'influx' do
		uri node[:influx][:uri]
		distribution node['lsb']['codename']
		components node[:influx][:components]
		key node[:influx][:key_uri]
	end

	apt_update 'all services' do 
		action :update
	end

elsif node[:platform] == 'centos'
	lsb = node[:platform_version].to_i
 	puts lsb
 	puts node[:kernel][:machine]

 	yum_repository 'influxdb' do
 		description 'Influx Database package'
 		baseurl "https://repos.influxdata.com/rhel/#{lsb}/#{node[:kernel][:machine]}/stable"
 		enabled true
 		gpgcheck true
 		gpgkey 'https://repos.influxdata.com/influxdb.key'
 	end

 	execute "yum update" do
 		command "yum update -y"
 	end
end
package 'influxdb'

service 'influxdb' do
	supports :start => true, :stop => true , :restart => true
	action [:enable, :start]
end