require 'spec_helper'
require 'snitch'

describe Snitch do
  describe "#connected_clients" do
    let(:row) { double 'row', value: double(to_mac: address) }
    let(:octal) { "\x04\x06p\x81\x05\x06\xB5\xE8" }
    let(:address) { "70:81:05:06:B5:E8" }
    let(:snitch) { Snitch.new }

    before do
      allow(YAML).to receive(:load_file).and_return('70:81:05:06:B5:E8' => client)
    end

    subject { snitch.connected_clients }

    context "when router is available" do
      let(:client) { "brian" }

      let(:manager) do
        double('manager').tap do |manager|
          allow(manager).to receive(:walk).and_yield(row)
        end
      end

      before do
        expect(SNMP::Manager).to receive(:open).and_yield(manager)
      end

      it "returns current client list array" do
        expect(subject).to eq [client]
      end
    end

    context "when router is unavailable" do
      let(:client) { [] }

      before do
        expect(SNMP::Manager).to receive(:open).and_raise(SocketError)
      end

      it "returns an empty array" do
        expect(subject).to eq []
      end
    end
  end
end
