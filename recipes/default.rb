Chef::Recipe.send(:include, BestIpFor)

include_recipe 'sudo::default'

package 'rsync'

group 'backupper' do
  action     :create
  group_name node['bpc']['client']['group']
  system     true
end

user 'backupper' do
  action   :create
  home     node['bpc']['client']['home']
  username node['bpc']['client']['user']
  gid      node['bpc']['client']['group']
  shell    '/bin/sh'
  system   true
  comment  'used by BackupPC server to backup node. Restricted to rsync only.'
end

directory 'backupper_ssh' do
  action    :create
  path      "#{node['bpc']['client']['home']}/.ssh"
  owner     node['bpc']['client']['user']
  group     node['bpc']['client']['group']
  mode      00700
  recursive true
end

public_key = node['bpc']['client']['ssh_public_key']
ipaddress = nil

if !Chef::Config[:solo] &&
  (backuppc = search(:node, 'bpc_ssh_public_key:*')[0])

  public_key = backuppc['bpc']['ssh_public_key']
  ipaddress  = best_ip_for(backuppc)
end

if public_key.empty?
  Chef::Log.warn 'No public key found, ' \
    'BackupPC might not be able to connect to this client.'
else
  template 'backupper_authorized_keys' do
    source 'authorized_keys.erb'
    path   "#{node['bpc']['client']['home']}/.ssh/authorized_keys"
    owner  node['bpc']['client']['user']
    group  node['bpc']['client']['group']
    mode   00600
    variables(
      public_key: public_key,
      restrictions: [
        (%Q{from="#{ipaddress}"} if ipaddress),
        'no-agent-forwarding',
        'no-port-forwarding',
        'no-X11-forwarding',
        'no-pty'
      ].compact.join(',')
    )
  end
end

sudo 'backuppc_rsync' do
  action    :install
  user      node['bpc']['client']['user']
  nopasswd  true
  runas     'root'
  defaults  ['!requiretty', 'env_reset']
  commands  ['/usr/bin/rsync --server --sender *']
end
