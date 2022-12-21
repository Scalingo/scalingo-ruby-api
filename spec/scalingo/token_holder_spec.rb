require "spec_helper"

RSpec.describe Scalingo::TokenHolder do
  subject(:token_holder_dummy_class) do
    Class.new { include(Scalingo::TokenHolder); attr_accessor :config }
  end

  describe "authenticate_with_bearer_token" do
    subject { token_holder.authenticate_with_bearer_token(token, expires_at: expires_at, raise_on_expired_token: false) }

    let(:token_holder) do
      holder = token_holder_dummy_class.new
      holder.config = Scalingo::Configuration.new

      holder
    end

    context "without expiration date" do
      let(:token) { "1234" }
      let(:expires_at) { nil }

      it "set the auth token" do
        expect(token_holder.authenticated?).to be false
        subject()
        expect(token_holder.authenticated?).to be true
      end
    end

    context "with an expiration date" do
      let(:token) { "1234" }
      let(:expires_at) { Time.now + 1.hour }

      it "refresh the auth token" do
        token_holder.authenticate_with_bearer_token(token, expires_at: 1.hour.ago, raise_on_expired_token: false)
        expect(token_holder.authenticated?).to be false

        subject()
        expect(token_holder.authenticated?).to be true
      end
    end
  end

  describe "authenticate_database_with_bearer_token" do
    subject { token_holder.authenticate_database_with_bearer_token(database_id, token, expires_at: expires_at, raise_on_expired_token: false) }

    let(:token_holder) do
      holder = token_holder_dummy_class.new
      holder.config = Scalingo::Configuration.new

      holder
    end

    let(:database_id) { "db-id-1234" }

    context "without expiration date" do
      let(:token) { "1234" }
      let(:expires_at) { nil }

      it "set the database auth token" do
        expect(token_holder.authenticated_for_database?(database_id)).to be false
        subject()
        expect(token_holder.authenticated_for_database?(database_id)).to be true
      end
    end

    context "with an expiration date" do
      let(:token) { "1234" }
      let(:expires_at) { Time.now + 1.hour }

      it "refresh the database token" do
        token_holder.authenticate_database_with_bearer_token(database_id, token, expires_at: 1.hour.ago, raise_on_expired_token: false)
        expect(token_holder.authenticated_for_database?(database_id)).to be false
        subject()
        expect(token_holder.authenticated_for_database?(database_id)).to be true
      end
    end
  end
end
