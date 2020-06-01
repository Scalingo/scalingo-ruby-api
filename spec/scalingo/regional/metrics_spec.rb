require "spec_helper"

RSpec.describe Scalingo::Regional::Metrics do
  describe_method "types" do
    context "guest" do
      subject { guest_endpoint }

      let(:stub_pattern) { "types-guest" }

      it_behaves_like "a successful response"
    end

    context "logged" do
      let(:stub_pattern) { "types-logged" }

      it_behaves_like "a successful response"
    end
  end

  describe_method "for" do
    context "cpu" do
      let(:arguments) { [meta[:app_id], meta[:for][:valid_cpu]] }
      let(:expected_count) { 181 }
      let(:stub_pattern) { "for-valid-cpu-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end

    context "router" do
      let(:arguments) { [meta[:app_id], meta[:for][:valid_router]] }
      let(:stub_pattern) { "for-valid-router-404" }

      it_behaves_like "a not found response"
    end

    context "invalid" do
      let(:arguments) { [meta[:app_id], meta[:for][:invalid]] }
      let(:stub_pattern) { "for-invalid-400" }

      it_behaves_like "a client error"
    end
  end
end
