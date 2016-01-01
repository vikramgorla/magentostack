# Encoding: utf-8
#
# Cookbook Name:: magentostack
# Attributes:: apache-fpm
#
# Copyright 2014, Rackspace Hosting
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# otherwise apache2::default overwrites default vhost, then we overwrite it with
# web_app further down, causing the file to churn on every chef converge
override['apache']['default_site_enabled'] = false

# there is a bug in mod_fastcgi, Magento <1.9 or EE <1.14 need this mod_fastcgi
# only require if we decide to use Magento <1.9 or EE <1.14
# default['apache']['mod_fastcgi']['download_url'] = 'http://www.fastcgi.com/dist/mod_fastcgi-SNAP-0910052141.tar.gz'

# Configure default Magento Vhosts
default['magentostack']['web']['domain'] = 'localhost'
default['magentostack']['web']['http_port'] = '80'
default['magentostack']['web']['https_port'] = '443'
default['magentostack']['web']['server_aliases'] = node['fqdn']
default['magentostack']['web']['ssl'] = true # default to configuring ssl
default['magentostack']['web']['ssl_autosigned'] = true
default['magentostack']['web']['ssl_custom'] = false
default['magentostack']['web']['ssl_custom_databag'] = 'certificates'
default['magentostack']['web']['ssl_custom_databag_item'] = 'magento'
default['magentostack']['web']['cookbook'] = 'magentostack'
default['magentostack']['web']['template'] = 'apache2/magento_vhost.erb'
default['magentostack']['web']['fastcgi']['add_handler_options'] = '.php'
default['magentostack']['web']['dir'] = "#{node['apache']['docroot_dir']}/magento"

site_name = node['magentostack']['web']['domain']
default['magentostack']['web']['ssl_key'] = "#{node['apache']['dir']}/ssl/#{site_name}.key"
default['magentostack']['web']['ssl_cert'] = "#{node['apache']['dir']}/ssl/#{site_name}.pem"
default['magentostack']['web']['ssl_chain'] = nil
default['magentostack']['web']['ssl_custom_basename'] = nil

# Install php dependencies for Magento
default['magentostack']['php']['version'] = 'php55'
case node['platform_family']
when 'rhel'
  default['magentostack']['php55']['packages'] = %w(
    php55u-gd
    php55u-mysqlnd
    php55u-mcrypt
    php55u-xml
    php55u-xmlrpc
    php55u-soap
    php55u-pecl-redis
    php55u-opcache
    php55u-mbstring
  )

  default['magentostack']['php54']['packages'] = %w(
    php54-gd
    php54-mysqlnd
    php54-mcrypt
    php54-xml
    php54-xmlrpc
    php54-soap
    php54-pecl-redis
    php54-opcache
    php54-mbstring
  )
### opcache is built in Php for Ubuntu
when 'debian'
  default['magentostack']['php']['packages'] = %w(
    php5-gd
    php5-mysqlnd
    php5-mcrypt
    php5-xmlrpc
    php5-redis
    php5-curl
    php5-mbstring
  )
end
#    php5-soap

# Php configuration
default['php-fpm']['pools'] = {
  'www' => {
    enable: true,
    listen: '127.0.0.1:9000',
    php_options: {
      'php_admin_flag[opcache.enable]' => '1',
      'php_admin_value[opcache.memory_consumption]' => '256',
      'php_admin_value[opcache.interned_strings_buffer]' => '8',
      'php_admin_value[opcache.max_accelerated_files]' => '4000',
      'php_admin_flag[opcache.fast_shutdown]' => '1',
      'php_admin_flag[opcache.validate_timestamps]' => '1',
      'php_admin_value[memory_limit]' => '512M',
      'php_admin_value[max_execution_time]' => '1800',
      'php_admin_value[realpath_cache_size]' => '256k',
      'php_admin_value[realpath_cache_ttl]' => '7200',
      'php_admin_value[open_basedir]' => 'none',
      'php_admin_value[session.entropy_length]' => '32',
      'php_admin_value[session.entropy_file]' => '/dev/urandom'
    }
  }
}
# cloud monitoring
node.default['magentostack']['web']['monitor']['cookbook'] = 'magentostack'
node.default['magentostack']['web']['monitor']['template'] = 'cloud-monitoring/monitoring-remote-http.yaml.erb'
node.default['magentostack']['web']['monitor']['disabled'] = false
node.default['magentostack']['web']['monitor']['period'] = 60
node.default['magentostack']['web']['monitor']['timeout'] = 15
node.default['magentostack']['web']['monitor']['alarm'] = false

# apache basic auth attributes and htaccess controls
node.default['apache']['parse_htaccess'] = false
node.default['apache']['basic_username'] = false
node.default['apache']['allow_from'] = false
node.default['apache']['htpasswd'] = "#{node['apache']['dir']}/htpassword"

