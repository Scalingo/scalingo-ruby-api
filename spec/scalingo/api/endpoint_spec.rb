require "spec_helper"

RSpec.describe Scalingo::API::Endpoint do
  subject { described_class.new(client) }

  let(:client) { double }

  describe "initialize" do
    it "stores the client" do
      instance = described_class.new(:client)

      expect(instance.client).to eq(:client)
    end
  end

  describe "connection" do
    it "delegates the connection to the client" do
      expect(client).to receive(:connection).and_return(:value).once
      expect(subject.connection).to eq :value
    end
  end
end
