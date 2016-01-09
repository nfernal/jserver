#
# Cookbook Name:: jserver
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'yum-epel::default'
include_recipe 'java::default'
include_recipe 'tomcat_latest::default'
include_recipe 'iptables::default'
include_recipe 'jserver::fw_rules'
include_recipe 'maven::default'
include_recipe 'maven::settings'
include_recipe 'clamav::default'
include_recipe 'jenkins::master'
include_recipe 'jserver::mysql'
# include_recipe 'deploy-play::default'

package 'httpd' do
  action :install
end

service 'httpd' do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end