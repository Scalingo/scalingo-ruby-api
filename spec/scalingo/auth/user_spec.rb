require "spec_helper"

RSpec.describe Scalingo::Auth::User do
  let(:endpoint) { auth.user }

  context "self" do
    let(:response) { endpoint.self }
    let(:stub_pattern) { "self" }

    it_behaves_like "a successful response"
  end

  context "update" do
    context "success" do
      let(:response) { endpoint.update(meta[:update][:valid]) }
      let(:stub_pattern) { "update-200" }

      it_behaves_like "a successful response"
    end

    context "unprocessable" do
      let(:response) { endpoint.update(meta[:update][:invalid]) }
      let(:stub_pattern) { "update-422" }

      it_behaves_like "an unprocessable request"
    end
  end
end
