#
#Cookbook Name:: rethink
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#

default['rethink']['db_package'] = 'rethinkdb'
default['rethink']['repo_uri'] = 'http://download.rethinkdb.com/apt'
default['rethink']['key'] = 'http://download.rethinkdb.com/apt/pubkey.gpg'
default['rethink']['conf_file_path'] = '/etc/rethinkdb/instances.d/cluster_node.conf'
default['rethink']['master_conf_path'] = '/etc/rethinkdb/instances.d/cluster_instance.conf'
