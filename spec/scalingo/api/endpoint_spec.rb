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
    it "forwards unpack to Response without keys" do
      mock = proc { 1 }

      expect(Scalingo::API::Response).to receive(:unpack).with(client, keys: [], &mock).and_return(:d).once
      expect(subject.send(:unpack, &mock)).to eq :d
    end

    it "forwards unpack to Response with a single key" do
      mock = proc { 1 }

      expect(Scalingo::API::Response).to receive(:unpack).with(client, keys: [:a], &mock).and_return(:d).once
      expect(subject.send(:unpack, :a, &mock)).to eq :d
    end

    it "forwards unpack to Response with many keys" do
      mock = proc { 1 }

      expect(Scalingo::API::Response).to receive(:unpack).with(client, keys: [:a, :b], &mock).and_return(:d).once
      expect(subject.send(:unpack, :a, :b, &mock)).to eq :d
    end
  end
end
