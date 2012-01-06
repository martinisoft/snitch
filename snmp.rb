require 'snmp'
require 'pry'

SNMP::Manager.open(host: 'andromeda.local') do |manager|
  manager.walk("ipNetToMediaPhysAddress") do |row|
    addr = row.value.encode.to_s
    mac = []
    addr.each_byte do |c|
      if c.to_s(16) == "0"
        mac << "00"
      elsif c.to_s(16).size == 1
        mac << "0#{c.to_s(16)}"
      else
        mac << c.to_s(16)
      end
    end
    mac.shift(2)
    pp mac.join(":")
  end
end
