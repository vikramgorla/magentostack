root_dir = "#{node['magento']['capistrano']['docroot']}"

folder_owner = node['magento']['capistrano']["folder_owner"]
folder_group = node['magento']['capistrano']["folder_owner"]

%w{releases shared}.each do |dir|
  directory "#{root_dir}/#{dir}" do
    recursive true
  end
end

node['magento']['capistrano']['app_shared_dirs'].each do |dir|
  full_path = "#{root_dir}/shared/#{dir}"
  directory full_path do
    recursive true
    not_if do File.exists?(full_path) end
  end
end

node['magento']['capistrano']['app_shared_files'].each do |file|
  directory File.dirname("#{root_dir}/shared/#{file}") do
    recursive true
  end
end

bash "fix_deployment_permissions_recursively" do
  code "chown -R #{folder_owner}:#{folder_group} #{root_dir}"
end

if node['magento']['capistrano']['nfs_path']
  node['magento']['capistrano']['nfs_symlinks'].each do |symlink|
    full_path = "#{root_dir}/shared/#{symlink}"
    directory full_path do
      action :delete
      not_if do File.symlink?(full_path) end
    end
    link full_path do
      link_type :symbolic
      to "#{node['magento']['capistrano']['nfs_path']}#{symlink}"
    end
  end
end
