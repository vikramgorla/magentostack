######## WORKING COPY ##########

include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"

package "mod_extract_forwarded"

file "#{node['apache']['dir']}/conf.d/mod_extract_forwarded.conf" do
  action :delete
end

enable = true
conf = true
restart = false

  include_recipe 'apache2::default'

  filename    = "mod_extract_forwarded.so"
  module_path = "#{node['apache']['libexec_dir']}/#{params[:filename]}"
  identifier  = "extract_forwarded_module"

  apache_mod extract_forwarded

  file "#{node['apache']['dir']}/mods-available/extract_forwarded.load" do
    content "LoadModule #{params[:identifier]} #{params[:module_path]}\n"
    mode '0644'
  end

  if params[:enable]
    execute "a2enmod #{params[:extract_forwarded]}" do
      command "/usr/sbin/a2enmod #{params[:extract_forwarded]}"
      if params[:restart]
        notifies :restart, 'service[apache2]', :delayed
      else
        notifies :reload, 'service[apache2]', :delayed
      end
      not_if do
        ::File.symlink?("#{node['apache']['dir']}/mods-enabled/#{params[:extract_forwarded]}.load") &&
          (::File.exist?("#{node['apache']['dir']}/mods-available/#{params[:extract_forwarded]}.conf") ? ::File.symlink?("#{node['apache']['dir']}/mods-enabled/#{params[:extract_forwarded]}.conf") : true)
      end
    end
  else
    execute "a2dismod #{params[:extract_forwarded]}" do
      command "/usr/sbin/a2dismod #{params[:extract_forwarded]}"
      if params[:restart]
        notifies :restart, 'service[apache2]', :delayed
      else
        notifies :reload, 'service[apache2]', :delayed
      end
      only_if { ::File.symlink?("#{node['apache']['dir']}/mods-enabled/#{params[:extract_forwarded]}.load") }
    end
  end
end
