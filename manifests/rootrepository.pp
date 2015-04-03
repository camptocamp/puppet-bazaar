define bazaar::rootrepository(
  $ensure = present,
  $owner  = 'root',
  $group  = 'root',
  $mode   = '2775',
  $rootpack = false
) {

  $_ensure = $ensure ? {
    'present' => directory,
    default => absent
  }

  file {"/srv/bzr/${name}":
    ensure => $_ensure,
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

  $command = $rootpack ? {
    true    => "umask 0002; bzr init --rich-root-pack /srv/bzr/${name}",
    default => "umask 0002; bzr init /srv/bzr/${name}",
  }

  exec {"init ${name}":
    command => $command,
    user    => $owner,
    creates => "/srv/bzr/${name}/.bzr",
    require => Package['bzr'],
  }

  file {"/srv/bzr/${name}/.bzr":
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    require => Exec["init ${name}"],
  }
}
