# Encoding: utf-8
#
# Cookbook Name:: magentostack
# Recipe:: nfs_client
#
# Copyright 2014, Rackspace Hosting
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'chef-sugar'
include_recipe 'nfs::default'
nfs_server_node = node['magentostack']['nfs_client']['nfs_server_node']
export_name =  node['magentostack']['nfs_client']['export_name']
export_root = node['magentostack']['nfs_client']['export_root']

mount_point_path = node['magentostack']['nfs_client']['mount_point']

directory mount_point_path do
  user node['apache']['user']
  group node['apache']['group']
end

mount mount_point_path do
  device "#{nfs_server_node}:#{export_root}/#{export_name}"
  fstype 'nfs'
  options ['rw', 'sec=sys']
  action [:mount, :enable]
end
