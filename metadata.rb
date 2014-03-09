def read(file, default = '')
  IO.read(File.join(File.dirname(__FILE__), file))
rescue Errno::ENOENT
  default
end

name             'backuppc-client'
maintainer       'Jean Mertz'
maintainer_email 'jean@kabisa.nl'
license          'All rights reserved'
description      'Installs/Configures backuppc-client'
long_description read('README.md')
version          read('VERSION', '0.1.0')

supports 'debian', '~> 7.1.0'
depends 'sudo', '~> 2.5.2'
