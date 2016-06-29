define sysctl::conf($ensure='present', $value='') {

  include sysctl

  $key = $title

  if $ensure in [ 'present', 'absent' ] {
    $ensure_real = $ensure
  } else {
    fail("Sysctl::Conf[${key}]: parameter ensure must be present or absent")
  }

  case $ensure_real {
    'absent':
      {
        Augeas <| title == "sysctl.conf/${key}/rm" |>
      }
    'present':
      {
        if ($value == '') {
          fail("Sysctl::Conf[${key}]: parameter value must be defined")
        }

        augeas { "sysctl.conf/${key}/add" :
          lens    => 'Sysctl.lns',
          incl    => '/etc/sysctl.conf',
          context => '/files/etc/sysctl.conf',
          changes => [
            "set ${key} '${value}'",
          ],
          onlyif  => "match ${key} size == 0",
          notify  => Exec['sysctl/reload']
        }

        augeas { "sysctl.conf/${key}/modify" :
          lens    => 'Sysctl.lns',
          incl    => '/etc/sysctl.conf',
          context => '/files/etc/sysctl.conf',
          changes => [
            "set ${key} '${value}'",
          ],
          onlyif  => "match ${key} size == 1",
          notify  => Exec['sysctl/reload']
        }
      }
    default: { notice('The given ensure parameter is not supported') }
  }

  @augeas { "sysctl.conf/${key}/rm" :
    lens    => 'Sysctl.lns',
    incl    => '/etc/sysctl.conf',
    context => '/files/etc/sysctl.conf',
    changes => [
      "rm ${key}",
    ],
    onlyif  => "match ${key} size > 0",
    notify  => Exec['sysctl/reload']
  }

}
