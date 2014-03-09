# User and group the BackupPC server uses to log in to this client
#
default['bpc']['client']['user'] = 'backupper'
default['bpc']['client']['group'] = 'backupper'

# Home directory for the backupper user, used to store .ssh/authorized_keys
# which includes the public key of the `backuppc` user on the BackupPC server.
#
default['bpc']['client']['home'] = "/var/lib/#{node['bpc']['client']['user']}"

# Hostname used in the BackupPC interface. This can be any name you like, the
# connection to this client will be made based on the Ohai public IP.
#
default['bpc']['client']['name'] = node.name

# This is the user that has access to this node through the BackupPC user
# interface. Any user defined here should also be added to the htpasswd file on
# the BackupPC server to be able to identify the user upon login.
#
default['bpc']['client']['owner'] = ''

# Wether the BackupPC server should use DHCP to look up this host. Should be
# left to "0" for fixed IP's.
#
default['bpc']['client']['dhcp'] = 0

# Shares (or locations) BackupPC should back up.
#
# For more details, see the `backuppc-server` cookbook's attributes/config.rb
# file, specifically the `RsyncShareName` details.
#
# NOTE: Chef will merge all arrays in the same attribute scopes. So if you want
#       to backup other paths and remove the default '/' path, you should
#       override this value using the `node.override` scope, instead of
#       `node.default`.
#
default['bpc']['client']['shares'] = ['/']

# Paths and/or files to include during backups.
#
# This can either be an array of strings, or an array of hashes. Hashes are
# required when the above mentioned "shares" attribute contains multiple
# locations to backup (the hash keys defining which share the includes should
# apply to).
#
# For more details, see the `backuppc-server` cookbook's attributes/config.rb
# file, specifically the `BackupFilesOnly` details.
#
default['bpc']['client']['includes'] = []

# Paths and/or files to exclude. See `includes` for more details.
#
default['bpc']['client']['excludes'] = []

# This attribute can contain the public key associated with the private key
# present on the BackupPC server for the "backupper" user.
#
# If left empty, this cookbook will search nodes on the Chef server that have
# the `backuppc-server::default` recipe in the run_list, and get the public key
# from the first matched server.
#
default['bpc']['client']['ssh_public_key'] = ''

# All BackupPC configurations can be overwritten on a per-client basis.
#
# The above attributes define the most common attributes a client would want to
# overwrite. Any other attributes can be added to the `config` hash. See
# `backuppc-server` cookbook's attributes/config.rb for more details.
#
default['bpc']['client']['config'] = {}

# We use `/etc/sudoers.d` to restrict the "backupper" user - connecting from
# the BackupPC server - to only run the `rsync` application as root.
#
default['authorization']['sudo']['include_sudoers_d'] = true
