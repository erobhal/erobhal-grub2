# == Class: grub2::params
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

class grub2::params {
  $config_template              = 'grub2/grub.erb'
  $users_template               = 'grub2/01_users.erb'
  $all_cmdline_linux_extra      = hiera_array('grub2::cmdline_linux_extra',[])

  if defined('kdump') {
    include kdump
    $cmdline_linux_crashkernel    = $kdump::grub2_crashkernel
  }

  if ($::operatingsystem == 'RedHat' and $::operatingsystemmajrelease == '7') {
    $efi_enabled          = false
    $cmdline_linux_base   = 'rd.lvm.lv=sysvg/lv_swap biosdevname=0 rd.lvm.lv=sysvg/lv_root rhgb quiet'
    $timeout              = '5'
    $default              = 'saved'
    $savedefault          = undef
    $serial_command       = undef
    $terminal             = undef
    $terminal_input       = undef
    $terminal_output      = 'console'
    $disable_recovery     = 'true'
    $disable_submenu      = 'true'
    $superuser_name       = undef
    $superuser_pw_clear   = undef
    $superuser_pw_pbkdf2  = undef
  }
}

