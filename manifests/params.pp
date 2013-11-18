# Class: samba::params
#
class samba::params {

  case $::osfamily {
    'RedHat': {
      $service = [ 'smb', 'nmb' ]
    }
    'Debian': {
      if $::operatingsystem == 'Ubuntu' {
        $service = [ 'smbd' ]
      } else {
        $service = [ 'samba' ]
      }
    }
    default: {
      $service = [ 'samba' ]
    }
  }

}

