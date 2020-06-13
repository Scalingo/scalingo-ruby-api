require "spec_helper"

RSpec.describe Scalingo::BearerToken do
  let(:value) { "my-token" }
  let(:expires_at) { nil }

  subject { described_class.new(value, expires_at: expires_at) }

  describe "initialize" do
    it "stores the value" do
      instance = described_class.new(:value)

      expect(instance.value).to eq(:value)
      expect(instance.expires_at).to eq nil
    end

    it "stores the expiration" do
      expiration = Time.now + 1.hour
      instance = described_class.new(:value, expires_at: expiration)

      expect(instance.value).to eq(:value)
      expect(instance.expires_at).to eq expiration
    end
  end

  describe "expired?" do
    context "without expiration" do
      it { expect(subject).not_to be_expired }
    end

    context "with the expiration in the future" do
      let(:expires_at) { Time.current + 1.hour }
      it { expect(subject).not_to be_expired }
    end

    context "with the expiration in the past" do
      let(:expires_at) { Time.current - 1.minute }
      it { expect(subject).to be_expired }
    end
  end

  describe "value" do
    context "when raising on expired token" do
      before do
        allow(Scalingo.config).to receive(:raise_on_expired_token).and_return(true)
      end

      it "raises when expired" do
        expect(subject).to receive(:expired?).and_return(true)
        expect { subject.value }.to raise_error(Scalingo::Error::ExpiredToken)
      end

      it "returns the value when not expired" do
        expect(subject).to receive(:expired?).and_return(false)
        expect(subject.value).to eq(value)
      end
    end

    context "when not raising on expired token" do
      before do
        allow(Scalingo.config).to receive(:raise_on_expired_token).and_return(false)
      end

      it "returns the value when expired" do
        expect(subject).to receive(:expired?).and_return(true)
        expect(subject.value).to eq(value)
      end

      it "returns the value when not expired" do
        expect(subject).to receive(:expired?).and_return(false)
        expect(subject.value).to eq(value)
      end
    end
  end
end
