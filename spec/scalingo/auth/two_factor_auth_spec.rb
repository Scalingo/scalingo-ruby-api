require "spec_helper"

RSpec.describe Scalingo::Auth::TwoFactorAuth do
  let(:client) {
    client = Scalingo::Client.new
    client.authenticate_with(bearer_token: Scalingo::VALID_BEARER_TOKEN)
    client.auth.two_factor_auth
  }

  context "status" do
    let(:response) { client.status }
    let(:stub_pattern) { "status" }

    it_behaves_like "a successful response"
  end

  context "initiate" do
    context "success" do
      let(:response) { client.initiate }
      let(:stub_pattern) { "initiate-success" }

      it_behaves_like "a successful response", 201
    end

    context "wrong provider" do
      let(:response) { client.initiate("wrong") }
      let(:stub_pattern) { "initiate-wrong-provider" }

      it_behaves_like "a client error"
    end

    context "already enabled" do
      let(:response) { client.initiate }
      let(:stub_pattern) { "initiate-already-enabled" }

      it_behaves_like "a client error"
    end
  end

  context "validate" do
    context "success" do
      let(:response) { client.validate(123456) }
      let(:stub_pattern) { "validate-success" }

      it_behaves_like "a successful response", 201
    end

    context "wrong provider" do
      let(:response) { client.validate("wrong") }
      let(:stub_pattern) { "validate-wrong" }

      it_behaves_like "a client error"
    end

    context "already enabled" do
      let(:response) { client.validate(123456) }
      let(:stub_pattern) { "validate-not-initiated" }

      it_behaves_like "a client error"
    end

  end

  context "disable" do
    context "success" do
      let(:response) { client.disable }
      let(:stub_pattern) { "disable-success" }

      it_behaves_like "a successful response"
    end

    context "not enabled" do
      let(:response) { client.disable }
      let(:stub_pattern) { "disable-not-initiated" }

      it_behaves_like "a client error"
    end
  end
end
