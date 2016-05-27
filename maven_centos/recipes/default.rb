#
# Cookbook Name:: maven_centos
# Recipe:: default
#
# Copyright 2016, Relevance lab
#
# All rights reserved - Do Not Redistribute
#


# package  'java-1.7.0-openjdk'do
  # action :install

# end

if node[:platform_family] == 'debian'
 execute "silent execution" do
  command 'echo oracle-java8-set-default shared/accepted-oracle-license-v1-1 select true | debconf-set-selections'
 end
 
 apt_repository 'webupd8team-trusty' do
  uri 'ppa:webupd8team/java'
  distribution node[:lsb][:codename]
 end

 apt_update 'all services' do
  action :update
 end

 apt_package 'oracle-java8-set-default'

elsif node[:platform_family] == 'rhel'

 execute "update" do
  command "yum -y update"
 end

 bash "install of java" do
  code <<-EOH
  wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm"
  sudo yum localinstall -y  jdk-8u60-linux-x64.rpm
  EOH
  not_if { ::File.exists?('jdk-8u60-linux-x64.rpm') }
 end

 if Dir.exists?("/usr/java/jdk1.8.0_60")
     compile_flags = 'JAVA_HOME="/usr/java/jdk1.8.0_60"'
 end

 ruby_block 'set-env-java-home' do
   block do
      ENV['JAVA_HOME'] = compile_flags
    end
    not_if { ENV['JAVA_HOME'] == compile_flags }
 end

 ruby_block 'Set JAVA_HOME in /etc/environment' do
     block do
       file = Chef::Util::FileEdit.new('/etc/environment')
       file.insert_line_if_no_match(/^JAVA_HOME=/, compile_flags)
       file.write_file
     end
 end
end

ark "apache-maven" do 
url 'http://mirror.olnevhost.net/pub/apache/maven/binaries/apache-maven-3.2.1-bin.tar.gz'
path '/opt'

action :put
end

execute 'move file' do
 cwd '/opt'
 command ' sudo mv apache-maven /opt/maven'
not_if do File.exists?('/opt/maven') end
  end

execute 'maven/bin' do
  command 'sudo ln -s /opt/maven/bin/mvn /usr/bin/mvn'
  not_if do ::File.exists?('/usr/bin/mvn') end
  end
 
 
  template '/etc/profile.d/maven.sh' do
  source 'maven.sh.erb'
  owner 'root'
  group 'root'
  mode  '0777'
 end

 execute 'echo' do
 cwd '/opt'
 command 'sh -c echo "MVN_HOME=/opt/mvn" >> /etc/profile.d/maven.sh'
 

 end




