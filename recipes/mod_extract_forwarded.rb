include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"

package "mod_extract_forwarded"

apache_module 'extract_forwarded' do
  conf true
end
