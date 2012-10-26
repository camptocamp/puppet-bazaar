class bazaar::client {
  case $lsbdistcodename {
    lucid,
    lenny,
    squeeze: {
      package{['bzr', 'bzrtools', 'python-paramiko']:
        ensure => installed,
      }
    }
    default: {
      fail "Unknown bzr package for ${lsbdistcodename}"
    }
  }
}
