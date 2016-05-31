
#
# Cookbook Name:: rethink
# Recipe:: rethinkdb_master
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

template node[:rethink][:master_conf_path] do
	source 'cluster_instance.conf.erb'
end

service 'rethinkdb' do
	supports :restrat => true, :status => true
	action [:enable, :start ]
end