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
  $grub2_sysconfig_file         = $grub2::params::grub2_sysconfig_file,
  $grub2_sysconfig_link         = $grub2::params::grub2_sysconfig_link,
  $grub2_mkconfig_command       = $grub2::params::grub2_mkconfig_command,
  $grub2_configfile_bios        = $grub2::params::grub2_configfile_bios,
  $grub2_configfile_efi         = $grub2::params::grub2_configfile_efi,
  $grub2_configfile_users       = $grub2::params::grub2_configfile_users,
  $config_template              = $grub2::params::config_template,
  $users_template               = $grub2::params::users_template,
  $superuser_name               = $grub2::params::superuser_name,
  $superuser_pw_clear           = $grub2::params::superuser_pw_clear,
  $superuser_pw_pbkdf2          = $grub2::params::superuser_pw_pbkdf2,
  $cmdline_linux_base           = $grub2::params::cmdline_linux_base,
  $all_cmdline_linux_extra      = $grub2::params::all_cmdline_linux_extra,
  $timeout                      = $grub2::params::timeout,
  $hidden_timeout               = $grub2::params::hidden_timeout,
  $hidden_timeout_quiet         = $grub2::params::hidden_timeout_quiet,
  $default                      = $grub2::params::default,
  $savedefault                  = $grub2::params::savedefault,
  $background                   = $grub2::params::background,
  $serial_command               = $grub2::params::serial_command,
  $terminal                     = $grub2::params::terminal,
  $terminal_input               = $grub2::params::terminal_input,
  $terminal_output              = $grub2::params::terminal_output,
  $disable_recovery             = $grub2::params::disable_recovery,
  $disable_submenu              = $grub2::params::disable_submenu,
  $disable_os_prober            = $grub2::params::disable_os_prober,
) inherits grub2::params {

  # Parameter sanitation
  if $hidden_timeout_quiet != undef and is_string($hidden_timeout_quiet) and $hidden_timeout_quiet =~ /(?i:true|false)/ {
    $_hidden_timeout_quiet = str2bool($hidden_timeout_quiet)
  }
  else {
    $_hidden_timeout_quiet = $hidden_timeout_quiet
  }

  if $savedefault != undef and is_string($savedefault) and $savedefault =~ /(?i:true|false)/ {
    $_savedefault = str2bool($savedefault)
  }
  else {
    $_savedefault = $savedefault
  }

  if $disable_recovery != undef and is_string($disable_recovery) and $disable_recovery =~ /(?i:true|false)/ {
    $_disable_recovery = str2bool($disable_recovery)
  }
  else {
    $_disable_recovery = $disable_recovery
  }

  if $disable_submenu != undef and is_string($disable_submenu) and $disable_submenu =~ /(?i:true|false)/ {
    $_disable_submenu = str2bool($disable_submenu)
  }
  else {
    $_disable_submenu = $disable_submenu
  }

  if $disable_os_prober != undef and is_string($disable_os_prober) and $disable_os_prober =~ /(?i:true|false)/ {
    $_disable_os_prober = str2bool($disable_os_prober)
  }
  else {
    $_disable_os_prober = $disable_os_prober
  }

  if $::efi_boot != undef and is_string($::efi_boot) and $::efi_boot =~ /(?i:true|false)/ {
    $_efi_boot = str2bool($::efi_boot)
  }
  elsif is_bool($::efi_boot) {
    $_efi_boot = $::efi_boot
  }

  include grub2::params::verify

  if ($_efi_boot) {
    $mkconfig_output = $grub2_configfile_efi
  }
  else {
    $mkconfig_output = $grub2_configfile_bios
  }

  if ($::operatingsystem == 'RedHat' and $::operatingsystemmajrelease == '7') {

    file { $grub2_sysconfig_file:
      ensure  => present,
      content => template($config_template),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => Exec['mkconfig_grub2'],
    }

    if ($grub2_sysconfig_link) {
      file { $grub2_sysconfig_link:
        ensure  => 'link',
        target  => $grub2_sysconfig_file,
        require => File[$grub2_sysconfig_file],
      }
    }

    if ($superuser_name != undef) {
      if ($superuser_pw_pbkdf2 != undef or $superuser_pw_clear != undef) {
        file { $grub2_configfile_users:
          ensure  => present,
          content => template($users_template),
          owner   => 'root',
          group   => 'root',
          mode    => '0750',
          notify  => Exec['mkconfig_grub2'],
        }
      }
    }
    else {
        file { $grub2_configfile_users:
          ensure => absent,
          notify => Exec['mkconfig_grub2'],
        }
    }

    exec {'mkconfig_grub2':
      command     => "${grub2_mkconfig_command} --output=${mkconfig_output}",
      refreshonly => true,
    }

  } else {
    notify {"This grub2 module supports RedHat 7, you are running ${::operatingsystem} ${::operatingsystemmajrelease}":}
  }
}



