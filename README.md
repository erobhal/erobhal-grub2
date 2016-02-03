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
- **Hiera array** : *Empty by default*

#### cmdline_linux_base
- Base parameters to add to CMDLINE_LINUX
- **STRING** : *OS specific*

#### timeout
- Number of seconds that menu will appear
- **STRING** : *5*

#### default
- Default boot entry. You probably don't want to change this.
- **STRING** : *saved*

#### terminal_output
- Terminal output.
- **STRING** : *console*

#### disable_recovery
- tbd
- **STRING** : *true*

#### disable_submeny
- tbd
- **STRING** : *true*

### Example
```ruby
    class { 'grub2':
      cmdline_linux_base    => 'rd.lvm.lv=sysvg/lv_swap biosdevname=0 rd.lvm.lv=sysvg/lv_root rhgb quiet',
      timeout               => '5',
      disable_recovery      => 'true',
      disable_submenu       => 'true'
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

