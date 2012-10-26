define bazaar::repository(
  $ensure = present,
  $owner  = 'root',
  $group  = 'root',
  $mode   = '2775',
  $rootpack = false
) {

  file {"/srv/bzr/${name}":
    owner => $owner,
    group => $group,
    mode  => $mode,
  }

  case $ensure {
    present: {
      File["/srv/bzr/${name}"] {
        present => directory,
      }

      $init_command = $rootpack? {
        true    => "umask 0002; bzr init-repo --rich-root-pack /srv/bzr/${name}",
        default => "umask 0002; bzr init-repo /srv/bzr/${name}",
      }

      exec {"init-repo ${name}":
        command => $init_command,
        user    => $owner,
        creates => "/srv/bzr/${name}/.bzr",
        require => Package['bzr'],
      }

      file {"/srv/bzr/${name}/.bzr":
        ensure  => $ensure,
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        require => Exec["init-repo ${name}"],
      }
    }

    absent: {
      File["/srv/bzr/${name}"] {
        ensure  => absent,
        backup  => false,
        force   => true,
        recurse => true,
      }
    }

    default: {
      fail "Unknown \$ensure '${ensure}' for ${name} bazaar::repostitory"
    }
  }

}
