require 'snmp'

ROUTER_NAME='andromeda.local'

# Open SNMP connection
SNMP::Manager.open(host: ROUTER_NAME) do |manager|
  # Walk the SNMP Table for Net Addresses, see RFC 1213-MIB
  manager.walk("ipNetToMediaPhysAddress") do |row|
    # Re-encode the OCTET String that comes back
    addr = row.value.encode.to_s
    mac = []
    # Loop over each byte to a nicer HEX value
    addr.each_byte do |c|
      if c.to_s(16) == "0"
        mac << "00"
      elsif c.to_s(16).size == 1
        mac << "0#{c.to_s(16)}"
      else
        mac << c.to_s(16)
      end
    end
    # The table returns 2 extra numbers in front, drop 'em
    mac.shift(2)
    # Squish them together to form a MAC address
    pp mac.join(":")
  end
end
