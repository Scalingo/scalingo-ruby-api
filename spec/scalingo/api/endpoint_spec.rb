require "spec_helper"

RSpec.describe Scalingo::API::Endpoint do
  let(:client) { double }

  subject { described_class.new(client) }

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

  describe "unpack" do
    it "forwards unpack to Response" do
      expect(Scalingo::API::Response).to receive(:unpack).with(client, :a, :b, :c).and_return(:d).once

      expect(subject.send(:unpack, :a, :b, :c)).to eq :d
    end
  end
end
