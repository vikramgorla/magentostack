node.default['magento']['capistrano']['docroot'] = '/var/www/html/magento'
node.default['magento']['capistrano']['folder_owner'] = 'apache'
node.default['magento']['capistrano']["app_shared_dirs"] = ["/app/etc", "/sitemaps", "/media", "/var", "/staging"]
node.default['magento']['capistrano']["app_shared_files"] = ["/app/etc/local.xml"]
node.default['magento']['capistrano']["nfs_path"] = '/san/nfs-fs'
node.default['magento']['capistrano']["nfs_symlinks"] = ["/media", "/staging", "/sitemaps", "/var/locks"]
