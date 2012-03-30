require 'spec_helper'
require 'snitch'

describe Snitch do
  describe "#connected_clients" do
    let(:row) { double 'row', value: stub(encode: address) }
    let(:address) { "\x04\x06p\x81\x05\x06\xB5\xE8" }
    let(:snitch) { Snitch.new }

    before do
      YAML.stub load_file: { '70:81:05:06:B5:E8' => client }
    end

    subject { snitch.connected_clients }

    context "when router is available" do
      let(:client) { "brian" }

      let(:manager) do
        double('manager').tap do |manager|
          manager.stub(:walk).and_yield(row)
        end
      end

      before do
        SNMP::Manager.should_receive(:open).and_yield(manager)
      end

      it "returns current client list array" do
        should eq [client]
      end
    end

    context "when router is unavailable" do
      let(:client) { [] }

      before do
        SNMP::Manager.should_receive(:open).and_raise(SocketError)
      end

      it "returns an empty array" do
        should eq []
      end
    end
  end
end
