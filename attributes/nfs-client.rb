# clients
node.default['magentostack']['nfs_client']['mount_point'] = '/mnt/nfs'
node.default['magentostack']['nfs_client']['symlink_target'] = 'media'

node.default['magentostack']['nfs_client']['nfs_server_node'] = false
node.default['magentostack']['nfs_client']['export_name'] = false
node.default['magentostack']['nfs_client']['export_root'] = false
default['magentostack']['nfs_client']['enable_mount'] = true
