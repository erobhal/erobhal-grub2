# == Class: grub2::params::verify
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

class grub2::params::verify (
  $grub2_sysconfig_file         = $grub2::grub2_sysconfig_file,
  $grub2_sysconfig_link         = $grub2::grub2_sysconfig_link,
  $grub2_mkconfig_command       = $grub2::grub2_mkconfig_command,
  $grub2_configfile_bios        = $grub2::grub2_configfile_bios,
  $grub2_configfile_efi         = $grub2::grub2_configfile_efi,
  $grub2_configfile_users       = $grub2::grub2_configfile_users,
  $config_template              = $grub2::config_template,
  $users_template               = $grub2::users_template,
  $superuser_name               = $grub2::superuser_name,
  $superuser_pw_clear           = $grub2::superuser_pw_clear,
  $superuser_pw_pbkdf2          = $grub2::superuser_pw_pbkdf2,
  $cmdline_linux_base           = $grub2::cmdline_linux_base,
  $all_cmdline_linux_extra      = $grub2::all_cmdline_linux_extra,
  $timeout                      = $grub2::timeout,
  $hidden_timeout               = $grub2::hidden_timeout,
  $hidden_timeout_quiet         = $grub2::_hidden_timeout_quiet,
  $default                      = $grub2::default,
  $savedefault                  = $grub2::_savedefault,
  $background                   = $grub2::background,
  $serial_command               = $grub2::serial_command,
  $terminal                     = $grub2::terminal,
  $terminal_input               = $grub2::terminal_input,
  $terminal_output              = $grub2::terminal_output,
  $disable_recovery             = $grub2::_disable_recovery,
  $disable_submenu              = $grub2::_disable_submenu,
  $disable_os_prober            = $grub2::_disable_os_prober,
) {

  # Mandatory parameters
  unless $config_template != undef and is_string($config_template) {
    fail('Parameter config_template has wrong input type. It is mandatory and should be string.')
  }
  unless $users_template != undef and is_string($users_template) {
    fail('Parameter users_template has wrong input type. It is mandatory and should be string.')
  }
  unless $grub2_sysconfig_file != undef and is_absolute_path($grub2_sysconfig_file) {
    fail('Parameter grub2_sysconfig_file has wrong input type. It is mandatory and should be absolute path.')
  }
  unless $grub2_mkconfig_command != undef and is_string($grub2_mkconfig_command) {
    fail('Parameter grub2_mkconfig_command has wrong input type. It is mandatory and should be string.')
  }
  unless $grub2_configfile_bios != undef and is_absolute_path($grub2_configfile_bios) {
    fail('Parameter grub2_configfile_bios has wrong input type. It is mandatory and should be absolute path.')
  }
  unless $grub2_configfile_efi != undef and is_absolute_path($grub2_configfile_efi) {
    fail('Parameter grub2_configfile_efi has wrong input type. It is mandatory and should be absolute path.')
  }
  unless $grub2_configfile_users != undef and is_absolute_path($grub2_configfile_users) {
    fail('Parameter grub2_configfile_users has wrong input type. It is mandatory and should be absolute path.')
  }

  # Optional parameters
  unless $superuser_name == undef or is_string($superuser_name) {
    fail('Parameter superuser_name has wrong input type. Should be string.')
  }
  unless $superuser_pw_clear == undef or is_string($superuser_pw_clear) {
    fail('Parameter superuser_pw_clear has wrong input type. Should be string.')
  }
  unless $superuser_pw_pbkdf2 == undef or is_string($superuser_pw_pbkdf2) {
    fail('Parameter superuser_pw_pbkdf2 has wrong input type. Should be string.')
  }
  unless $cmdline_linux_base == undef or is_string($cmdline_linux_base) {
    fail('Parameter cmdline_linux_base has wrong input type. Should be string.')
  }
  unless $all_cmdline_linux_extra == undef or is_array($all_cmdline_linux_extra) {
    fail('Parameter all_cmdline_linux_extra has wrong input type. Should be array.')
  }
  unless $timeout == undef or is_numeric($timeout) {
    fail('Parameter timeout has wrong input type. Should be numeric.')
  }
  unless $hidden_timeout == undef or is_numeric($hidden_timeout) {
    fail('Parameter hidden_timeout has wrong input type. Should be numeric.')
  }
  unless $hidden_timeout_quiet == undef or is_bool($hidden_timeout_quiet) {
    fail('Parameter hidden_timeout_quiet has wrong input type. Should be boolean.')
  }
  unless $default == undef or is_string($default) {
    fail('Parameter default has wrong input type. Should be string.')
  }
  unless $savedefault == undef or is_bool($savedefault) {
    fail('Parameter savedefault has wrong input type. Should be boolean.')
  }
  unless $background == undef or is_absolute_path($background) {
    fail('Parameter background has wrong input type. Should be absolute path.')
  }
  unless $serial_command == undef or is_string($serial_command) {
    fail('Parameter serial_command has wrong input type. Should be string.')
  }
  unless $terminal == undef or is_string($terminal) {
    fail('Parameter terminal has wrong input type. Should be string.')
  }
  unless $terminal_input == undef or is_string($terminal_input) {
    fail('Parameter terminal_input has wrong input type. Should be string.')
  }
  unless $terminal_output == undef or is_string($terminal_output) {
    fail('Parameter terminal_output has wrong input type. Should be string.')
  }
  unless $disable_recovery == undef or is_bool($disable_recovery) {
    fail('Parameter disable_recovery has wrong input type. Should be boolean.')
  }
  unless $disable_submenu == undef or is_bool($disable_submenu) {
    fail('Parameter disable_submenu has wrong input type. Should be boolean.')
  }
  unless $disable_os_prober == undef or is_bool($disable_os_prober) {
    fail('Parameter disable_os_prober has wrong input type. Should be boolean.')
  }

  if $superuser_pw_clear != undef or $superuser_pw_pbkdf2 != undef {
    if $superuser_name == undef {
      fail('Parameters superuser_pw require superuser_name to be set.')
    }
  }
  if $superuser_pw_clear != undef and $superuser_pw_pbkdf2 != undef {
    fail('Both superuser_pw_clear and superuser_pw_pbkdf2 can not be set at the same time.')
  }

}



