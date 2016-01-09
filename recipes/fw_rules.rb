#
# Cookbook Name:: jserver
# Recipe:: fw_rules
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


iptables_rule 'tomcat_ipt' do
  action :enable
end

iptables_rule 'httpd_ipt' do
  action :enable
end

iptables_rule 'mysql_ipt' do
  action :enable
end