class bazaar::client {
  case $lsbdistcodename {
    lucid,
    precise,
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
