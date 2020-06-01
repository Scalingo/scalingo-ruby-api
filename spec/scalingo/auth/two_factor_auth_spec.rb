require "spec_helper"

RSpec.describe Scalingo::Auth::TwoFactorAuth do
  let(:endpoint) { auth.two_factor_auth }

  context "status" do
    let(:response) { endpoint.status }
    let(:stub_pattern) { "status" }

    it_behaves_like "a successful response"

    context "request customization" do
      let(:method_name) { "status" }

      it_behaves_like "a method with a configurable request"
    end
  end

  context "initiate" do
    context "success" do
      let(:response) { endpoint.initiate }
      let(:stub_pattern) { "initiate-success" }

      it_behaves_like "a successful response", 201

      context "request customization" do
        let(:method_name) { "initiate" }
        let(:valid_arguments) { Scalingo::Auth::TwoFactorAuth::DEFAULT_PROVIDER }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "wrong provider" do
      let(:response) { endpoint.initiate(meta[:initiate][:invalid]) }
      let(:stub_pattern) { "initiate-wrong-provider" }

      it_behaves_like "a client error"
    end

    context "already enabled" do
      let(:response) { endpoint.initiate }
      let(:stub_pattern) { "initiate-already-enabled" }

      it_behaves_like "a client error"
    end
  end

  context "validate" do
    context "success" do
      let(:response) { endpoint.validate(meta[:validate][:valid]) }
      let(:stub_pattern) { "validate-success" }

      it_behaves_like "a successful response", 201

      context "request customization" do
        let(:method_name) { "validate" }
        let(:valid_arguments) { meta[:validate][:valid] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "wrong provider" do
      let(:response) { endpoint.validate(meta[:validate][:invalid]) }
      let(:stub_pattern) { "validate-wrong" }

      it_behaves_like "a client error"
    end

    context "already enabled" do
      let(:response) { endpoint.validate(meta[:validate][:invalid]) }
      let(:stub_pattern) { "validate-not-initiated" }

      it_behaves_like "a client error"
    end
  end

  context "disable" do
    context "success" do
      let(:response) { endpoint.disable }
      let(:stub_pattern) { "disable-success" }

      it_behaves_like "a successful response"

      context "request customization" do
        let(:method_name) { "disable" }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "not enabled" do
      let(:response) { endpoint.disable }
      let(:stub_pattern) { "disable-not-initiated" }

      it_behaves_like "a client error"
    end
  end
end
