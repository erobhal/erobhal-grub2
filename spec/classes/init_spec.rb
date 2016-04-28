require 'spec_helper'

describe 'grub2' do

  platforms = {
    'RedHat 7' =>
      {
        :osfamily => 'RedHat',
        :osrelease => '7',
      },
    'CentOS 7' =>
      {
        :osfamily => 'CentOS',
        :osrelease => '7',
      },
  }

  platforms.sort.each do |k,v|
    describe "on #{k}" do
      let(:facts) { {
        :operatingsystem => v[:osfamily],
        :operatingsystemmajrelease => v[:osrelease],
        :efi_boot => false,
      } }

      context "default params on #{k}" do
        it do
          should contain_file('/etc/default/grub').with({
            'ensure' => 'present',
            'owner' => 'root',
            'group' => 'root',
            'mode' => '0644',
          }).with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT

GRUB_TIMEOUT=5
GRUB_DEFAULT="saved"
GRUB_SAVEDEFAULT=false
GRUB_DISABLE_SUBMENU=true
GRUB_DISABLE_OS_PROBER=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="rd.lvm.lv=sysvg/lv_swap biosdevname=0 rd.lvm.lv=sysvg/lv_root rhgb quiet"
GRUB_DISABLE_RECOVERY=true
}
           ).that_notifies('Exec[mkconfig_grub2]')

        end
      end

      context "modified params on #{k}" do
      let(:params) { {
        :config_template => 'grub2/grub.erb',
        :users_template => 'grub2/01_users.erb',
        :cmdline_linux_base => '*CLB*',
        :all_cmdline_linux_extra => ['*CLE_1*','*CLE_2*'],
        :timeout => '5',
        :hidden_timeout => '5',
        :hidden_timeout_quiet => 'false',
        :default => '*DF*',
        :background => '/a/path',
        :savedefault => 'false',
        :serial_command => '*GSC*',
        :terminal => '*GT*',
        :terminal_input => '*TEI*',
        :terminal_output => '*TEO*',
        :disable_recovery => 'true',
        :disable_submenu => 'true',
        :disable_os_prober => 'true',
      } }
        it do
          should contain_file('/etc/default/grub').with({
            'ensure' => 'present',
            'owner' => 'root',
            'group' => 'root',
            'mode' => '0644',
          }).with_content(
%{# This file is being maintained by Puppet.
# DO NOT EDIT

GRUB_TIMEOUT=5
GRUB_HIDDEN_TIMEOUT=5
GRUB_HIDDEN_TIMEOUT_QUIET=false
GRUB_DEFAULT="*DF*"
GRUB_SAVEDEFAULT=false
GRUB_BACKGROUND="/a/path"
GRUB_DISABLE_SUBMENU=true
GRUB_DISABLE_OS_PROBER=true
GRUB_SERIAL_COMMAND="*GSC*"
GRUB_TERMINAL="*GT*"
GRUB_TERMINAL_INPUT="*TEI*"
GRUB_TERMINAL_OUTPUT="*TEO*"
GRUB_CMDLINE_LINUX="*CLE_1* *CLE_2* *CLB*"
GRUB_DISABLE_RECOVERY=true
}
           ).that_notifies('Exec[mkconfig_grub2]')

        end
      end

      context 'superuser with cleartext pw' do
      let(:params) { {
        :superuser_name => 'johndoe',
        :superuser_pw_clear => 'mypassword',
        :superuser_pw_pbkdf2 => :undef,
      } }
        it do
          should contain_file('/etc/grub.d/01_users').with({
            'ensure' => 'present',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0750',
          }).with_content(
%{# This file is managed with Puppet
# Please do not edit!!
#
cat <<EOF
set superusers="johndoe"
password johndoe mypassword
EOF
}
          ).that_notifies('Exec[mkconfig_grub2]')
        end
      end

      context 'superuser with encrypted pw' do
      let(:params) { {
        :superuser_name => 'johndoe',
        :superuser_pw_clear => :undef,
        :superuser_pw_pbkdf2 => 'grub.pbkdf2.sha512.10000.F59BF1E6BA97FE832CD4D584B81EA81EE638BA6F07979D3B40570B38D3661A6B356783BA0CFD3B7EC808FAE8C24CEFD729BFD91B58C310B8B3A792E2BDAEB124.05CDE0ABE5B72C2EF0587EF70C38A3D0B466C38A4D664060EA88AB3B525C840428DE8F7D4052E1B32B4BDE1C0A88040FE834B530EA65B6A1DD971531CB58C911',
      } }
        it do
          should contain_file('/etc/grub.d/01_users').with({
            'ensure' => 'present',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0750',
          }).with_content(
%{# This file is managed with Puppet
# Please do not edit!!
#
cat <<EOF
set superusers="johndoe"
password_pbkdf2 johndoe grub.pbkdf2.sha512.10000.F59BF1E6BA97FE832CD4D584B81EA81EE638BA6F07979D3B40570B38D3661A6B356783BA0CFD3B7EC808FAE8C24CEFD729BFD91B58C310B8B3A792E2BDAEB124.05CDE0ABE5B72C2EF0587EF70C38A3D0B466C38A4D664060EA88AB3B525C840428DE8F7D4052E1B32B4BDE1C0A88040FE834B530EA65B6A1DD971531CB58C911
EOF
}
          ).that_notifies('Exec[mkconfig_grub2]')
        end
      end

      context 'no superuser set' do
      let (:params) { {
        :superuser_name => :undef,
      } }
      it do
          should contain_file('/etc/grub.d/01_users').with({
            'ensure' => 'absent',
          }).that_notifies('Exec[mkconfig_grub2]')
        end
      end

      it do
        should contain_file('/etc/sysconfig/grub').with({
          'ensure' => 'link',
          'target' => '/etc/default/grub',
        }).that_requires('File[/etc/default/grub]')
      end

      context 'using bios' do
      let(:facts) { {
        :operatingsystem => v[:osfamily],
        :operatingsystemmajrelease => v[:osrelease],
        :efi_boot => false,
      } }
        it do
          should contain_exec('mkconfig_grub2').with({
            'command' => '/usr/sbin/grub2-mkconfig --output=/boot/grub2/grub.cfg',
            'refreshonly' => 'true',
          })
        end
      end

      context 'using efi' do
      let(:facts) { {
        :operatingsystem => v[:osfamily],
        :operatingsystemmajrelease => v[:osrelease],
        :efi_boot => true,
      } }
      let(:params) { {
        :config_template => 'grub2/grub.erb',
        :users_template => 'grub2/01_users.erb',
      } }
        it do
          should contain_exec('mkconfig_grub2').with({
            'command' => '/usr/sbin/grub2-mkconfig --output=/boot/efi/EFI/redhat/grub.cfg',
            'refreshonly' => 'true',
          })
        end
      end

      it { should compile.with_all_deps }

    end
  end

  describe 'not on RedHat 7' do
    let(:facts) { {
      :operatingsystem => 'WrongOS',
      :operatingsystemmajrelease => '0',
      :efi_boot => false,
    } }
    it 'should fail' do
      expect {
        should contain_class('grub2')
      }.to raise_error(Puppet::Error,/This grub2 module supports RedHat 7 and CentOS 7, you are running WrongOS 0/)
    end
  end
end

