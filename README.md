# puppet-samba

## Overview

Install, enable and configure a SAMBA Windows share server. Should work on
Red Hat Enterprise Linux (and clones such as CentOS), Debian (and derivatives
such as Ubuntu) and FreeBSD.

* `samba::server` : Main class to manage a Samba server

## Example Usage

```puppet
class { '::samba::server':
  workgroup            => 'EXAMPLE',
  server_string        => 'Example File Server 01',
  netbios_name         => 'F01',
  interfaces           => [ 'lo', 'eth0' ],
  hosts_allow          => [ '127.', '192.168.' ],
  local_master         => 'yes',
  map_to_guest         => 'Bad User',
  os_level             => '50',
  preferred_master     => 'yes',
  extra_global_options => [
    'printing = BSD',
    'printcap name = /dev/null',
  ],
  shares => {
    'homes' => [
      'comment = Home Directories',
      'browseable = no',
      'writable = yes',
    ],
    'pictures' => [
      'comment = Pictures',
      'path = /srv/pictures',
      'browseable = yes',
      'writable = yes',
      'guest ok = yes',
      'available = yes',
    ],
  },
  selinux_enable_home_dirs => true,
}
```

