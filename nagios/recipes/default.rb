case node['platform']
when 'debian', 'ubuntu'  
  node[:nagios][:ubuntu_package].each do|pkg|
      package pkg do
         action :install
       end
     end
service 'apache2' do
  action [ :enable, :start ]
end
include_recipe 'nagios::ubuntu'

when 'redhat', 'centos' , 'fedora'
  node[:nagios][:centos_package].each do|pkg|
      package pkg do
        action :install
      end  
    end
include_recipe 'nagios::centos'
end


