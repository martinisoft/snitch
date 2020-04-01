require 'spec_helper'
require 'snitch'

describe Snitch do
  describe "#connected_clients" do
    let(:snitch) { Snitch.new }
    let(:first_address) { "71:81:05:06:B5:E8" }
    let(:second_address) { "40:21:00:06:C5:F8" }
    let(:known_client) { "brian" }
    let(:first_client) { double 'row', value: double(to_mac: first_address) }
    let(:second_client) { double 'row', value: double(to_mac: second_address) }
    let(:known_clients) do
      {
        first_address => known_client,
        second_address => known_client
      }
    end

    let(:manager) do
      double('manager').tap do |manager|
        allow(manager).to receive(:walk).and_yield(first_client).and_yield(second_client)
      end
    end


    before do
      allow(YAML).to receive(:load_file).and_return(known_clients)
    end

    subject { snitch.connected_clients }

    context "when router is available" do
      before do
        expect(SNMP::Manager).to receive(:open).and_yield(manager)
      end

      context "when there are multiple MACs for a client" do
        it "returns one client for that MAC" do
          expect(subject).to eq [known_client]
        end
      end

      it "returns current client list array" do
        expect(subject).to eq [known_client]
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
