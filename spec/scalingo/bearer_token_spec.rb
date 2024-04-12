require "spec_helper"

RSpec.describe Scalingo::BearerToken do
  subject { described_class.new(value, raise_on_expired: raise_on_expired) }

  let(:duration) { 1.hour }
  let(:value) { Scalingo.generate_test_jwt(duration: duration) }
  let(:raise_on_expired) { false }

  context "without duration" do
    let(:duration) { nil }

    it "stores the value and no expiration" do
      instance = described_class.new(value)

      expect(instance.value).to eq(value)
      expect(instance.expires_at).to be_nil
    end

    it { is_expected.not_to be_expired }
  end

  context "with duration" do
    it "stores the value and the expiration" do
      instance = described_class.new(value)

      expect(instance.value).to eq(value)
      expect(instance.expires_at).to be_within(3.seconds).of(Time.now + duration)
    end

    it { is_expected.not_to be_expired }

    context "when the expiration date is in the past" do
      it "is expired" do
        subject # to initialize the subject

        travel_to Time.now + duration - 1.minute do
          expect(subject).not_to be_expired
        end

        travel_to Time.now + duration + 1.minute do
          expect(subject).to be_expired
        end
      end
    end
  end

  describe "value" do
    context "when raising on expired token" do
      let(:raise_on_expired) { true }

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
      let(:raise_on_expired) { false }

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
