require 'snmp'
require 'yaml'

class Snitch
  attr_accessor :client_list, :config

  def initialize
    @client_list = []
    @config = YAML.load_file("snitch.yml")
  end

  def update_client_list
    client_list.clear
    # Open SNMP connection
    SNMP::Manager.open(host: config['router_name']) do |manager|
      # Walk the SNMP Table for Net Addresses, see RFC 1213-MIB
      manager.walk("ipNetToMediaPhysAddress") do |row|
        # Re-encode and process the OCTET String that comes back
        addr = process_client_address(row.value.encode.to_s)
        # Squish them together to form a MAC address
        client_list << addr.join(":").upcase
      end
    end
  end

  def connected_clients
    client_list.map do |client|
      config[client]
    end.compact.uniq
  end

  private

  def process_client_address(address)
    mac = []
    # Loop over each byte to a nicer HEX value
    address.each_byte do |c|
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
    mac
  end
end
