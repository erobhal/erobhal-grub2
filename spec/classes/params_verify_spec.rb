require 'spec_helper'

describe 'grub2::params::verify' do

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

      context 'sending wrong type to parameter :config_template' do
      let(:params) { {
        :config_template => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :users_template' do
      let(:params) { {
        :users_template => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :grub2_sysconfig_file' do
      let(:params) { {
        :grub2_sysconfig_file => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :grub2_mkconfig_command' do
      let(:params) { {
        :grub2_mkconfig_command => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :grub2_configfile_bios' do
      let(:params) { {
        :grub2_configfile_bios => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :grub2_configfile_efi' do
      let(:params) { {
        :grub2_configfile_efi => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :grub2_configfile_users' do
      let(:params) { {
        :grub2_configfile_users => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :superuser_name' do
      let(:params) { {
        :superuser_name => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :superuser_pw_clear' do
      let(:params) { {
        :superuser_pw_clear => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :superuser_pw_pbkdf2' do
      let(:params) { {
        :superuser_pw_pbkdf2 => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :cmdline_linux_base' do
      let(:params) { {
        :cmdline_linux_base => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :all_cmdline_linux_extra' do
      let(:params) { {
        :all_cmdline_linux_extra => 'array',
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :timeout' do
      let(:params) { {
        :timeout => 'thirty',
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :hidden_timeout' do
      let(:params) { {
        :hidden_timeout => 'five',
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :hidden_timeout_quiet' do
      let(:params) { {
        :hidden_timeout_quiet => 'yes',
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :default' do
      let(:params) { {
        :default => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :savedefault' do
      let(:params) { {
        :savedefault => 'yes',
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :background' do
      let(:params) { {
        :background => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :serial_command' do
      let(:params) { {
        :serial_command => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :terminal' do
      let(:params) { {
        :terminal => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :terminal_input' do
      let(:params) { {
        :terminal_input => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :terminal_output' do
      let(:params) { {
        :terminal_output => false,
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :disable_recovery' do
      let(:params) { {
        :disable_recovery => 'yes',
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :disable_submenu' do
      let(:params) { {
        :disable_submenu => 'yes',
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'sending wrong type to parameter :disable_os_prober' do
      let(:params) { {
        :disable_os_prober => 'yes',
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/wrong input type/)
        end
      end

      context 'setting both :superuser_pw_clear and :superuser_pw_pbkdf2' do
      let(:params) { {
        :config_template => 'astring',
        :users_template => 'astring',
        :grub2_sysconfig_file => '/a/path',
        :grub2_mkconfig_command => 'astring',
        :grub2_configfile_bios => '/a/path',
        :grub2_configfile_efi => '/a/path',
        :grub2_configfile_users => '/a/path',
        :superuser_name => 'somebody',
        :superuser_pw_pbkdf2 => 'something',
        :superuser_pw_clear => 'someting',
      } }
        it 'should fail' do
          expect {
            should contain_class('grub2')
          }.to raise_error(Puppet::Error,/superuser_pw_clear and superuser_pw_pbkdf2 can not be set at the same time/)
        end
      end

    end
  end
end

