default['magento']['capistrano']['enabled'] = true
default['magento']['capistrano']['deploy_user'] = 'deploymentuser'
default['magento']['capistrano']["app_shared_dirs"] = ["/app/etc", "/sitemaps", "/media", "/var", "/staging"]
default['magento']['capistrano']["app_shared_files"] = ["/app/etc/local.xml"]
default['magento']['capistrano']["nfs_path"] = '/mnt/nfs'
default['magento']['capistrano']["nfs_symlinks"] = ["/media", "/staging", "/sitemaps", "/var/locks"]
