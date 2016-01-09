#
# Cookbook Name:: jserver
# Recipe:: mysql
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


password = node['mysql']['passwd']
salt = rand(36**8).to_s(36)
shadow_hash = password.crypt("$1$" + salt)

user 'mysql' do
  action :create
  comment 'mysql user'
  uid 1000
  gid 'users'
  home '/home/mysql'
  shell '/bin/bash'
  password shadow_hash
  supports :manage_home => true
end

mysql_service 'foo' do
  port '3306'
  version '5.6'
  initial_root_password 'password'  #Change this!!!!
  bind_address '0.0.0.0'
  action [:create, :start]
end

link '/var/lib/mysql/mysql.sock' do
  to "/var/run/mysql-#{node['mysql']['service_name']}/mysqld.sock"
end

bash 'mysql_remote_access' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    mysql --user=root --password=password --execute="GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;"
  EOH
  notifies :restart, "mysql_service[#{node['mysql']['service_name']}]"
end