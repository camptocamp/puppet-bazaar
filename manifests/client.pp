class bazaar::client {
  case $::osfamily {
    'Debian': {
      if $::operatingsystem == 'Debian' and versioncmp($::operatingsystemmajrelease, '6') < 0 {
        package {['bzr', 'python-paramiko']:
          ensure => present,
        }
      } else {
        package{['bzr', 'bzrtools', 'python-paramiko']:
          ensure => installed,
        }
      }
    }
    'RedHat': {
      package{'bzr':
        ensure => present,
      }
    }
    default: {
      fail "Unknown bzr package for ${::operatingsystem}"
    }
  }
}
