#efi_boot.rb
require 'facter'

Facter.add('efi_boot') do
  setcode do
    if File.directory? "/sys/firmware/efi"
      "true"
    else
      "false"
    end
  end
end

