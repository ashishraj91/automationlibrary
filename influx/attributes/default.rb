if node[:platform] == 'ubuntu'
	default[:influx][:uri] = "https://repos.influxdata.components/#{node[:platform]}"
	default[:influx][:components] = ['stable']
	default[:influx][:key_uri] = 'https://repos.influxdata.com/influxdb.key'
elsif node[:platform] == 'rhel'
	
end
