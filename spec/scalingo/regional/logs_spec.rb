require "spec_helper"

RSpec.describe Scalingo::Regional::Logs do
  let(:endpoint) { regional.logs }
  let(:guest_endpoint) { regional_guest.logs }

  context "get" do
    context "guest" do
      let(:response) { guest_endpoint.get(meta[:urls][:guest]) }
      let(:stub_pattern) { "get-guest-200" }

      it_behaves_like "a successful response"
    end

    context "logged" do
      let(:response) { endpoint.get(meta[:urls][:logged]) }
      let(:stub_pattern) { "get-logged-200" }

      it_behaves_like "a successful response"
    end

    context "with limit" do
      let(:response) { endpoint.get(meta[:urls][:with_limit], meta[:options]) }
      let(:stub_pattern) { "get-with-limit-200" }

      it_behaves_like "a successful response"
    end
  end

  context "archives" do
    context "success" do
      let(:response) { endpoint.archives(meta[:app_id]) }
      let(:expected_count) { 0 }
      let(:stub_pattern) { "archives-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end
end
