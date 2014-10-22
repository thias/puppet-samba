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
      } else {
        $service = [ 'samba' ]
      }
      $secretstdb = '/var/lib/samba/secrets.tdb'
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

