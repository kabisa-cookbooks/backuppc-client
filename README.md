# backuppc-client cookbook

Contrary to the cookbook title, this cookbook *does not* install any client
application. It does however prepare the node in question to be accessible by
the BackupPC server and set some sane defaults for backing up the node.

For this cookbook to be of any use, you should first set up a BackupPC server
node using the [backuppc-server][] cookbook.

[backuppc-server]: http://community.opscode.com/cookbooks/backuppc-server

## Requirements

### Platforms

* Debian-family

### Dependencies

* sudo `~> 2.5.2`

## Attributes

See the [default][] attribute files for configuration variables and their
explanation.

[default]: attributes/default.rb

## Recipes

### Default

After setting the configuration variables, all that is left to do is to include
the default recipe:

```ruby
include_recipe 'backuppc-client::default'
```

Your BackupPC server will find the nodes depending on this cookbook and uses the
defined cookbook attributes to configure the backup strategy.

## TODO

* add unit and integration tests
* restrict rsync-only command through `authorized_keys` and custom shell script

## License and Author

Author:: Jean Mertz (<jean@mertz.fm>)

Copyright 2014, Kabisa ICT

Licensed under the MIT License (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://opensource.org/licenses/MIT

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.
