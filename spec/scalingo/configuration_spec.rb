require "spec_helper"

RSpec.describe Scalingo::Configuration do
  subject { described_class.default }

  describe "default_region" do
    it "must be an existing region" do
      expect {
        subject.default_region = "another-region"
      }.to raise_error(ArgumentError)
    end
  end

  describe "regions" do
    it "can be assigned from a hash" do
      subject.regions = {
        local_name: "some-url"
      }

      expect(subject.regions.local_name).to eq "some-url"
    end

    it "can be assigned from a openstruct" do
      subject.regions = OpenStruct.new(local_name: "some-url")

      expect(subject.regions.local_name).to eq "some-url"
    end

    it "raises with an argument from the wrong type" do
      expect {
        subject.regions = "1"
      }.to raise_error(ArgumentError)
    end
  end

  describe "inheritance" do
    it "can inherit configuration from a parent" do
      object = described_class.new({}, subject)

      described_class::ATTRIBUTES.each do |attr|
        expect(object.public_send(attr)).to eq subject.public_send(attr)
      end
    end

    it "can uses local configuration when supplied, the parent other wise" do
      object = described_class.new({user_agent: "Agent"}, subject)

      (described_class::ATTRIBUTES - [:user_agent]).each do |attr|
        expect(object.public_send(attr)).to eq subject.public_send(attr)
      end

      expect(object.user_agent).to eq "Agent"
    end
  end
end
