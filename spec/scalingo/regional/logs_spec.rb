require "spec_helper"

RSpec.describe Scalingo::Regional::Logs do
  describe_method "get" do
    context "guest" do
      let(:arguments) { meta[:urls][:guest] }
      let(:params) { {connected: false} }
      let(:stub_pattern) { "get-guest-200" }

      it_behaves_like "a singular object response"
    end

    context "logged" do
      let(:arguments) { meta[:urls][:logged] }
      let(:params) { {connected: true} }
      let(:stub_pattern) { "get-logged-200" }

      it_behaves_like "a singular object response"
    end

    context "with limit" do
      let(:arguments) { meta[:urls][:with_limit] }
      let(:params) { meta[:options] }
      let(:stub_pattern) { "get-with-limit-200" }

      it_behaves_like "a singular object response"
    end
  end

  describe_method "archives" do
    context "success" do
      let(:params) { meta.slice(:app_id) }
      let(:expected_count) { 0 }
      let(:stub_pattern) { "archives-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a cursor paginated collection"
    end
  end
end
