require "spec_helper"

RSpec.describe Scalingo::Client do
  subject { described_class.new }

  describe "token" do
    it "wraps the token in a BearerToken" do
      expect(subject.token).to eq nil

      subject.token = "my-token"
      expect(subject.token).to be_a(Scalingo::BearerToken)
      expect(subject.token.value).to eq "my-token"

      subject.token = Scalingo::BearerToken.new("other-token")
      expect(subject.token).to be_a(Scalingo::BearerToken)
      expect(subject.token.value).to eq "other-token"
    end

    it "can query the authentication status" do
      expect(subject).not_to be_authenticated

      subject.token = "my-token"
      expect(subject).to be_authenticated

      subject.token = Scalingo::BearerToken.new("other-token")
      allow(subject.token).to receive(:expired?).and_return(false)
      expect(subject).to be_authenticated

      allow(subject.token).to receive(:expired?).and_return(true)
      expect(subject).not_to be_authenticated
    end
  end

  describe "authenticate_with" do
    it "raises without arguments" do
      expect { subject.authenticate_with }.to raise_error(ArgumentError)
    end

    it "raises with both more than one authentication type" do
      expect {
        subject.authenticate_with(access_token: :a, bearer_token: :b)
      }.to raise_error(ArgumentError)
    end

    it "raises if expires_at is supplied for an access_token" do
      expect {
        subject.authenticate_with(access_token: :a, expires_at: :b)
      }.to raise_error(ArgumentError)
    end

    context "with access token" do
      it "is successful with valid token" do
        fake_response = OpenStruct.new(
          successful?: true,
          data: {token: "response token"},
        )

        expect(subject.auth.tokens).to receive(:exchange).and_return(fake_response)

        expect(subject.authenticate_with(access_token: "access token")).to be true
        expect(subject.token.value).to eq "response token"
        expect(subject.token.expires_at).to be_within(1.second).of(Time.current + Scalingo.config.exchanged_token_validity)
      end

      it "fails with invalid token" do
        fake_response = OpenStruct.new(
          successful?: false,
        )

        expect(subject.auth.tokens).to receive(:exchange).and_return(fake_response)

        expect(subject.authenticate_with(access_token: "access token")).to be false
        expect(subject.token).to be nil
      end
    end

    context "with bearer token" do
      it "only sets the bearer token according to the arguments" do
        expect(subject.authenticate_with(bearer_token: "my token")).to be true
        expect(subject.token.value).to eq "my token"
        expect(subject.token.expires_at).to eq nil

        expect(subject.authenticate_with(bearer_token: Scalingo::BearerToken.new("my token"))).to be true
        expect(subject.token.value).to eq "my token"
        expect(subject.token.expires_at).to eq nil

        expect(subject.authenticate_with(bearer_token: "my token", expires_at: Time.now + 1.hour)).to be true
        expect(subject.token.value).to eq "my token"
        expect(subject.token.expires_at).not_to eq nil
      end
    end
  end
end
