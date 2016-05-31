#
#Cookbook Name:: rethink
# Recipe:: rethinkdb_node
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#

apt_repository 'rethinkdb' do
  uri          node[:rethink][:repo_uri]
  distribution node['lsb']['codename']
  components   ['main']
  key          node[:rethink][:key]
end

package node[:rethink][:db_package]


rethink_master =search(:node, 'role:rethinkdb')

template node[:rethink][:conf_file_path] do
	source 'cluster_instance.conf.erb'
	variables(
		:rethink_master => rethink_master
		)
end

service 'rethinkdb' do
	supports :restrat => true, :status => true
	action [:enable, :start ]
end
