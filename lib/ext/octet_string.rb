module SNMP
  class OctetString
    # Public: Create MacAddress from OctetString
    #
    # Examples
    #
    #   foo = SNMP::OctetString.new("foo")
    #   foo.to_mac
    #   => "66:6f:6f"
    #
    # Returns MAC Address String from OctetString
    def to_mac
      each_byte.map { |byte| "%02x" % byte }.join(':')
    end
  end
end
