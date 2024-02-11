require "spec_helper"

RSpec.describe Scalingo::Auth::TwoFactorAuth do
  describe_method "status" do
    let(:stub_pattern) { "status" }

    it_behaves_like "a singular object response"
  end

  describe_method "initiate" do
    context "success" do
      let(:body) { meta[:initiate][:valid] }
      let(:stub_pattern) { "initiate-success" }

      it_behaves_like "a singular object response", 201
    end

    context "wrong provider" do
      let(:body) { meta[:initiate][:invalid] }
      let(:stub_pattern) { "initiate-wrong-provider" }

      it_behaves_like "a client error"
    end

    context "already enabled" do
      let(:body) { meta[:initiate][:valid] }
      let(:stub_pattern) { "initiate-already-enabled" }

      it_behaves_like "a client error"
    end
  end

  describe_method "validate" do
    context "success" do
      let(:body) { meta[:validate][:valid] }
      let(:stub_pattern) { "validate-success" }
      let(:expected_keys) { %i[codes user] }

      it_behaves_like "a singular object response", 201
    end

    context "wrong provider" do
      let(:body) { meta[:validate][:invalid] }
      let(:stub_pattern) { "validate-wrong" }

      it_behaves_like "a client error"
    end

    context "already enabled" do
      let(:body) { meta[:validate][:invalid] }
      let(:stub_pattern) { "validate-not-initiated" }

      it_behaves_like "a client error"
    end
  end

  describe_method "disable" do
    context "success" do
      let(:stub_pattern) { "disable-success" }

      it_behaves_like "a singular object response"
    end

    context "not enabled" do
      let(:stub_pattern) { "disable-not-initiated" }

      it_behaves_like "a client error"
    end
  end
end
