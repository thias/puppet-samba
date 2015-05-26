# Class: samba::params
#
class samba::params {

  case $::osfamily {
    'RedHat': {
      if $::operatingsystemmajrelease == '5' {
        $service = [ 'smb' ]
      } else {
        $service = [ 'smb', 'nmb' ]
      }
      $secretstdb = '/var/lib/samba/private/secrets.tdb'
      $config_file = '/etc/samba/smb.conf'
      $package = 'samba'
    }
    'Debian': {
      if $::operatingsystem == 'Ubuntu' {
        $service = [ 'smbd' ]
        if versioncmp($::lsbdistrelease, '14.04') >= 0 {
          $secretstdb = '/var/lib/samba/private/secrets.tdb'
        } else {
          $secretstdb = '/var/lib/samba/secrets.tdb'
        }
      } else {
        $service = [ 'samba' ]
      }
      $config_file = '/etc/samba/smb.conf'
      $package = 'samba'
    }
    'Freebsd': {
      $service = [ 'samba' ]
      $secretstdb = '/var/lib/samba/secrets.tdb'
      $config_file = '/usr/local/etc/smb.conf'
      $package = 'samba36'
    }
    default: {
      $service = [ 'samba' ]
      $secretstdb = '/usr/local/samba/private/secrets.tdb'
      $config_file = '/etc/samba/smb.conf'
      $package = 'samba'
    }
  }

}

