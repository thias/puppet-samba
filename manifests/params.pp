# Class: samba::params
# vim: sts=2 ts=2 sw=2 expandtab autoindent
class samba::params {

  case $::osfamily {
    'RedHat': {
      $service = [ 'smb', 'nmb' ]
      $secretstdb = '/var/lib/samba/private/secrets.tdb'
      $samba_config_path = '/etc/smb.conf'
      $package_name = 'samba'
    }
    'Debian': {
      if $::operatingsystem == 'Ubuntu' {
        $service = [ 'smbd' ]
      } else {
        $service = [ 'samba' ]
      }
      $secretstdb = '/var/lib/samba/secrets.tdb'
      $samba_config_path = '/etc/smb.conf'
      $package_name = 'samba'
    }
    'Freebsd': {
        $service = [ 'samba' ]
        $samba_config_path = '/usr/local/etc/smb.conf'
        $package_name = 'samba36'
        $secretstdb = '/var/lib/samba/secrets.tdb'
    }
    default: {
      $service = [ 'samba' ]
      $secretstdb = '/usr/local/samba/private/secrets.tdb'
      $samba_config_path = '/etc/smb.conf'
      $package_name = 'samba'
    }
  }
}
