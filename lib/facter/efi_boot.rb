#efi_boot.rb
require 'facter'

Facter.add('efi_boot') do
  setcode do
    if File.directory? "/boot/efi"
      "true"
    else
      "false"
    end
  end
end

