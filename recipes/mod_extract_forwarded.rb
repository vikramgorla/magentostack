include_recipe "apache2::mod_proxy"

package "mod_extract_forwarded"

apache_module 'proxy_extract_forwarded' do
  conf true
  filename 'mod_extract_forwarded.so'
  identifier 'extract_forwarded_module'
end
