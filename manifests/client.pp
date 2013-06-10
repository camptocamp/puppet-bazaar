class bazaar::client {
  case $::osfamily {
    'Debian': {
      package{['bzr', 'bzrtools', 'python-paramiko']:
        ensure => installed,
      }
    }
    default: {
      fail "Unknown bzr package for ${::operatingsystem}"
    }
  }
}
