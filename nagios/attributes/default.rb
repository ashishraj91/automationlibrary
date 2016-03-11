#
# Cookbook Name:: nagios
# Recipe:: default
#
# Copyright 2016, Relevance Lab Pvt LTD, Inc.
#
# All rights reserved - Do Not Redistribute
#
#Packages to be installed
default[:nagios][:centos_package] = ["httpd","wget","php","gcc","glibc","glibc-common","gd","gd-devel","make","net-snmp"]
default[:nagios][:ubuntu_package] =  ["wget","apache2","apache2-utils","php5","libapache2-mod-php5","build-essential","libgd2-xpm-dev"]

#User group and directory
default[:nagios][:user] = 'nagios'
default[:nagios][:group] = 'nagcmd'
default[:nagios][:directory] = '/root/nagios'
default[:nagios][:cent_nagios_dir] = '/root/nagios/nagios-4.0.1'
default[:nagios][:cent_plugin_dir] = '/root/nagios/nagios-plugins-1.5'
default[:nagios][:opt] = '/opt'
default[:nagios][:ubuntu_nagios_dir] = '/opt/nagios-4.1.1'
default[:nagios][:ubuntu_plugin_dir] = '/opt/nagios-plugins-2.0.3'
default[:nagios][:nagios_conf] = '/etc/apache2/conf-available/nagios.conf'

#Nagios Core and Nagios plugins packages
default[:nagios][:centos_core] = 'http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-4.0.1.tar.gz'
default[:nagios][:centos_plugin] = 'https://www.nagios-plugins.org/download/nagios-plugins-1.5.tar.gz'
default[:nagios][:ubuntu_plugin] = 'http://nagios-plugins.org/download/nagios-plugins-2.0.3.tar.gz'
default[:nagios][:ubuntu_core] = 'https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.1.1.tar.gz'