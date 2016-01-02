default['magento']['varnish']['backend_servers'] = [
    {
        "name" => "web1",
        "ip" => "127.0.0.1",
        "connect_timeout" => '240s',
        "first_byte_timeout" => '240s',
        "between_bytes_timeout" => '240s',
        "max_connections" => 800
    }
]
default['magento']['varnish']['trusted_servers'] = [
    "127.0.0.1"
]
default['varnish']['cookies'] = ['currency', 'store']
default['magento']['varnish']['ttl_for_static_files'] = '30d'
default['magento']['varnish']['probe']['timeout'] = '90s'
default['magento']['varnish']['additional_vcls'] = []
default['magento']['varnish']['additional_recv_subs'] = []
default['magento']['varnish']['additional_hash_subs'] = []
default['magento']['varnish']['director_strategy'] = 'random'
default['magento']['apache']['unsecure_port'] = node['magentostack']['web']['http_port']
default['magento']['app']['admin_frontname'] = 'admin'
