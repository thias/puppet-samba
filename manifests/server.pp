# Class: samba::server
#
# Samba server.
#
# For all main options, see the smb.conf(5) and samba(7) man pages.
# For the SELinux related options, see smbd_selinux(8).
#
# Sample Usage :
#  include samba::server
#
class samba::server (
  # Main smb.conf options
  $workgroup                = 'MYGROUP',
  $server_string            = 'Samba Server Version %v',
  $netbios_name             = '',
  $interfaces               = [],
  $hosts_allow              = [],
  $log_file                 = '/var/log/samba/log.%m',
  $max_log_size             = '10000',
  $passdb_backend           = 'tdbsam',
  $domain_master            = false,
  $domain_logons            = false,
  $local_master             = undef,
  $security                 = 'user',
  $map_to_guest             = undef,
  $guest_account            = undef,
  $os_level                 = undef,
  $preferred_master         = undef,
  $extra_global_options     = [],
  $shares                   = {},
  # SELinux options
  $selinux_enable_home_dirs = false,
  $selinux_export_all_rw    = false,
  # LDAP options
  $ldap_suffix              = undef,
  $ldap_url                 = undef,
  $ldap_ssl                 = 'off',
  $ldap_admin_dn            = undef,
  $ldap_admin_dn_pwd        = undef,
  $ldap_group_suffix        = undef,
  $ldap_machine_suffix      = undef,
  $ldap_user_suffix         = undef,
) inherits ::samba::params {

  # Main package and service
  package { $::samba::params::package: ensure => installed }
  service { $::samba::params::service:
    ensure    => running,
    enable    => true,
    hasstatus => true,
    subscribe => File[$::samba::params::config_file],
  }

  file { $::samba::params::config_file:
    require => Package[$::samba::params::package],
    content => template('samba/smb.conf.erb'),
  }

  if $ldap_admin_dn_pwd {
    package { 'tdb-tools' : ensure => installed }

    exec { "/usr/bin/smbpasswd -w \"${ldap_admin_dn_pwd}\"":
      unless  => "/usr/bin/tdbdump ${::samba::params::secretstdb} | /bin/grep -e '^data([0-9]\\+) = \"${ldap_admin_dn_pwd}\\\\00\"$'",
      require => [
        File[$::samba::params::config_file],
        Package['tdb-tools'],
      ],
      notify  => Service[$::samba::params::service],
    }
  }

  # SELinux options ($::selinux is a fact, so it's a string, not a boolean)
  if $::selinux == 'true' {
    Selboolean { persistent => true }
    if $selinux_enable_home_dirs {
      selboolean { 'samba_enable_home_dirs': value => 'on' }
    }
    if $selinux_export_all_rw {
      selboolean { 'samba_export_all_rw': value => 'on' }
    }
  }

}

