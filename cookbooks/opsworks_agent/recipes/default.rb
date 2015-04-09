#
# Cookbook Name:: local_opsworks
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{  curl libxml2-dev libxslt-dev libyaml-dev }.each do |pk|
 package pk
end

%w{ /etc/aws/opsworks/ /opt/aws/opsworks/ /var/log/aws/opsworks/ /var/lib/aws/opsworks/ /var/lib/cloud }.each do |dr|
  directory dr do
    owner 'root'
    recursive true
    group 'root'
    mode '0755'
    action :create
  end
end


remote_file '/tmp/opsworks-agent.tgz' do
  owner 'root'
  group 'root'
  mode '0644'
  source 'https://opsworks-instance-agent.s3.amazonaws.com/33200020141203204624/opsworks-agent-installer.tgz'
end

bash 'install opsworks agent' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  tar -xvzpof opsworks-agent.tgz
  opsworks-agent-installer/opsworks-agent/bin/installer_wrapper.sh -R opsworks-instance-assets.s3.amazonaws.com
  EOH
end

template '/etc/aws/opsworks/instance-agent.yml' do
  source 'instance-agent.yml.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
template '/var/lib/aws/opsworks/client.yml' do
  source 'client.yml.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
