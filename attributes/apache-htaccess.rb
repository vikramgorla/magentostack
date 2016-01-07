node.default['apache']['htpasswd_user'] = 'strongusername'
node.default['apache']['htpasswd_password'] = 'strongpassword'

#default value for mod_extract_forwarded (if used) to be overrided if you need 
node['apache']['mod_extract_forwarded']['accept'] = 'all'
