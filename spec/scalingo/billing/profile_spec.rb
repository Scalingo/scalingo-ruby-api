require "spec_helper"

RSpec.describe Scalingo::Billing::Profile do
  describe_method "show" do
    context "existing" do
      let(:stub_pattern) { "show-200" }

      it_behaves_like "a singular object response"
    end

    context "not yet created" do
      let(:stub_pattern) { "show-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "create" do
    context "success" do
      let(:body) { meta[:create][:valid] }
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a singular object response", 201
    end

    context "already existing" do
      let(:stub_pattern) { "create-400" }

      it_behaves_like "a client error"
    end

    context "unprocessable" do
      let(:body) { meta[:create][:invalid] }
      let(:stub_pattern) { "create-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  describe_method "update" do
    context "success" do
      let(:params) { {id: meta[:id]} }
      let(:body) { meta[:update][:valid] }
      let(:stub_pattern) { "update-200" }

      it_behaves_like "a singular object response"
    end

    context "unprocessable" do
      let(:params) { {id: meta[:id]} }
      let(:body) { meta[:update][:invalid] }
      let(:stub_pattern) { "update-422" }

      it_behaves_like "an unprocessable request"
    end
  end
end
