[![Build Status](https://travis-ci.org/erobhal/puppet-module-grub2.svg?branch=master)](https://travis-ci.org/erobhal/puppet-module-grub2)

# erobhal-grub2

This module manages GRUB 2 bootloader. It does not modify the
grub2 configurations files directly but changes the OS specific
configuration files (for example /etc/sysconfig/grub on RedHat)
and then uses the OS supplied grub2-mkconfig to generate
the config files. It will never reboot a system after
configuration.

## Supported distributions
- Red Hat

## Parameters

#### config_template
- Internal. Puppet template to use
- **STRING** : *'grub2/grub.erb'*

#### all_cmdline_linux_extra
- Internal. Used to flatten hiera_array into string
- **STRING** : *Empty by default*

#### cmdline_linux_extra
- Aditional parameters to add to CMDLINE_LINUX 
- **ARRAY** : *Empty by default*

#### cmdline_linux_base
- Base parameters to add to CMDLINE_LINUX
- **STRING** : *OS specific*

#### timeout
- Number of seconds that the menu will be visible.
- **STRING** : *'5'*

#### hidden_timeout
- Wait this many seconds for the user to press a key. During this period
  no menu is shown unless the user presses a key. If no key is pressed,
  control is passed to GRUB _TIMEOUT when the GRUB_HIDDEN_TIMEOUT expires.
- **STRING** : *Empty by default*

#### hidden_timeout_quiet
- Valid settings: true/false. Determines whether a countdown timer is displayed
  on a blank screen when using the GRUB_HIDDEN_TIMEOUT feature.
- **BOOLEAN** : *Empty by default*

#### default
- Default boot entry. Setting it to 'saved' enables the "grub2-reboot"
  and "grub2-set-default" commands to set the default OS for future boots.
- **STRING** : *'saved'*

#### savedefault
- Valid settings: true/false. If set to true this setting will automatically
  set the last selected OS from the menu as the default OS on the next boot.
- **BOOLEAN** : *false*

#### background
- Sets the background image, enter the full path to the image here.
- **STRING** : *Empty by default*

#### terminal
- Set to 'console' to disable graphical terminal.
- **STRING** : *Empty by default*

#### terminal_input
- tbd
- **STRING** : *Empty by default*

#### terminal_output
- Terminal output.
- **STRING** : *console*

#### disable_recovery
- Valid settings: true/false.
- **BOOLEAN** : *true*

#### disable_submeny
- Valid settings: true/false.
- **BOOLEAN** : *true*

#### disable_os_prober
 - Valid settings: true/false. This entry is used to prevent GRUB from adding the
   results of os-prober to the menu. A value of "true" disables the os-prober
   check of other partitions for operating systems, including Windows, Linux,
   OSX and Hurd, during execution of the update-grub command.
 - **BOOLEAN** : *true*

### Example
```ruby
    class { 'grub2':
      cmdline_linux_base    => 'rd.lvm.lv=sysvg/lv_swap biosdevname=0 rd.lvm.lv=sysvg/lv_root rhgb quiet',
      timeout               => '5',
      disable_recovery      => true,
      disable_submenu       => true
    }
```
### Hiera support

This module also supports the configuration of the parameters it exposes
using Hiera. To set the value of `timeout` to `10`, you would use:
```yaml
grub2::timeout: 10
```

In adition to this, cmd_linux_extra is an hiera_array where setting can be
added at multiple levels in your Hiera files:

Level 1:
```yaml
grub2::cmdline_linux_extra:
  - vga=normal
```

Level 2:
```yaml
grub2::cmdline_linux_extra:
  - nomodeset
```

This would end up in 'vga=normal nomodset' being added to CMDLINE_LINUX.

