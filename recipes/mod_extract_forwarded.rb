include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"

package "mod_extract_forwarded"

apache_module 'proxy_extract_forwarded' do
  conf true
  filename 'mod_extract_forwarded.so'
end
