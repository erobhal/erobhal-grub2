# == Class: grub2
#
# See README for documentation
#
# === Authors
#
# Robert Hallgren <robert.e.hallgren@ericsson.com>
#
# === Copyright
#
# Copyright 2016 Ericsson AB, unless otherwise noted.
#

class grub2 (
  $config_template              = $grub2::params::config_template,
  $users_template               = $grub2::params::users_template,
  $superuser_name               = $grub2::params::superuser_name,
  $superuser_pw_clear           = $grub2::params::superuser_pw_clear,
  $superuser_pw_pbkdf2          = $grub2::params::superuser_pw_pbkdf2,
  $cmdline_linux_base           = $grub2::params::cmdline_linux_base,
  $all_cmdline_linux_extra      = $grub2::params::all_cmdline_linux_extra,
  $timeout                      = $grub2::params::timeout,
  $default                      = $grub2::params::default,
  $savedefault                  = $grub2::params::savedefault,
  $serial_command               = $grub2::params::serial_command,
  $terminal                     = $grub2::params::terminal,
  $terminal_input               = $grub2::params::terminal_input,
  $terminal_output              = $grub2::params::terminal_output,
  $disable_recovery             = $grub2::params::disable_recovery,
  $disable_submenu              = $grub2::params::disable_submenu,
) inherits grub2::params {

  if ($::operatingsystem == 'RedHat' and $::operatingsystemmajrelease == '7') {

    if ($::efi_boot == 'true') {
      $mkconfig_output = '/boot/efi/EFI/redhat/grub.cfg'
    }
    else {
      $mkconfig_output = '/boot/grub2/grub.cfg'
    }

    file {'/etc/default/grub':
      ensure  => present,
      content => template($config_template),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => Exec['mkconfig_grub2'],
    }

    file {'/etc/sysconfig/grub':
      ensure  => 'link',
      target  => '/etc/default/grub',
      require => File['/etc/default/grub'],
    }

    if ($superuser_name != undef) {
      if ($superuser_pw_pbkdf2 != undef or $superuser_pw_clear != undef) {
        file {'/etc/grub.d/01_users':
          ensure  => present,
          content => template($users_template),
          owner   => 'root',
          group   => 'root',
          mode    => '0750',
          notify  => Exec['mkconfig_grub2'],
        }
      }
    }


    exec {'mkconfig_grub2':
      command     => "/usr/sbin/grub2-mkconfig --output=${mkconfig_output}",
      refreshonly => true,
    }
  } else {
    notify {"This grub2 module supports RedHat 7, you are running ${::operatingsystem} ${::operatingsystemmajrelease}":}
  }
}



