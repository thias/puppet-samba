# Class: samba::params
#
class samba::params {

  case $::osfamily {
    'RedHat': {
      $service = [ 'smb', 'nmb' ]
      $secretstdb = '/var/lib/samba/private/secrets.tdb'
    }
    'Debian': {
      if $::operatingsystem == 'Ubuntu' {
        $service = [ 'smbd' ]
      } else {
        $service = [ 'samba' ]
      }
      $secretstdb = '/var/lib/samba/secrets.tdb'
    }
    default: {
      $service = [ 'samba' ]
      $secretstdb = '/usr/local/samba/private/secrets.tdb'
    }
  }

}

