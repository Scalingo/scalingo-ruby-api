require "spec_helper"

RSpec.describe Scalingo::Client do
  subject { described_class.new }

  let(:timed_jwt) { Scalingo.generate_test_jwt(duration: 1.hour) }
  let(:other_jwt) { Scalingo.generate_test_jwt(duration: nil) }

  describe "token" do
    it "wraps the token in a BearerToken" do
      expect(subject.token).to be_nil

      subject.token = timed_jwt
      expect(subject.token).to be_a(Scalingo::BearerToken)
      expect(subject.token.value).to eq(timed_jwt)

      subject.token = Scalingo::BearerToken.new(other_jwt)
      expect(subject.token).to be_a(Scalingo::BearerToken)
      expect(subject.token.value).to eq(other_jwt)
    end

    it "can query the authentication status" do
      expect(subject).not_to be_authenticated

      subject.token = timed_jwt
      expect(subject).to be_authenticated

      subject.token = Scalingo::BearerToken.new(other_jwt)
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

    context "with access token" do
      it "is successful with valid token" do
        fake_response = OpenStruct.new(
          success?: true,
          body: timed_jwt
        )

        expect(subject.auth.tokens).to receive(:exchange).and_return(fake_response)

        expect(subject.authenticate_with(access_token: "access token")).to be true
        expect(subject.token.value).to eq(timed_jwt)
        expect(subject.token.expires_at).to be_within(3.seconds).of(Time.current + 1.hour)
      end

      it "fails with invalid token" do
        fake_response = OpenStruct.new(
          success?: false
        )

        expect(subject.auth.tokens).to receive(:exchange).and_return(fake_response)

        expect(subject.authenticate_with(access_token: "access token")).to be false
        expect(subject.token).to be_nil
      end
    end

    context "with bearer token" do
      it "only sets the bearer token according to the arguments" do
        expect(subject.authenticate_with(bearer_token: timed_jwt)).to be true
        expect(subject.token.value).to eq(timed_jwt)
        expect(subject.token.expires_at).not_to be_nil

        expect(subject.authenticate_with(bearer_token: Scalingo::BearerToken.new(timed_jwt))).to be true
        expect(subject.token.value).to eq(timed_jwt)
        expect(subject.token.expires_at).not_to be_nil

        expect(subject.authenticate_with(bearer_token: other_jwt)).to be true
        expect(subject.token.value).to eq(other_jwt)
        expect(subject.token.expires_at).to be_nil
      end
    end
  end

  describe "self" do
    it "returns the authenticated user" do
      expect(subject.auth.user).to receive(:find).and_return(:user)
      expect(subject.self).to eq :user
    end
  end
end
