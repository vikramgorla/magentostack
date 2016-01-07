include_recipe "apache2::mod_proxy"

package "mod_extract_forwarded"

apache_module 'extract_forwarded' do
  conf true
end
