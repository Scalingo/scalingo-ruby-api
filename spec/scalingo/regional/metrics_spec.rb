require "spec_helper"

RSpec.describe Scalingo::Regional::Metrics do
  let(:endpoint) { regional.metrics }
  let(:guest_endpoint) { regional_guest.metrics }

  context "types" do
    context "guest" do
      let(:response) { guest_endpoint.types }
      let(:stub_pattern) { "types-guest" }

      it_behaves_like "a successful response"
    end

    context "logged" do
      let(:response) { endpoint.types }
      let(:stub_pattern) { "types-logged" }

      it_behaves_like "a successful response"

      context "request customization" do
        let(:method_name) { "types" }

        it_behaves_like "a method with a configurable request"
      end
    end
  end

  context "for" do
    context "cpu" do
      let(:response) { endpoint.for(meta[:app_id], meta[:for][:valid_cpu]) }
      let(:expected_count) { 181 }
      let(:stub_pattern) { "for-valid-cpu-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"


      context "request customization" do
        let(:method_name) { "for" }
        let(:valid_arguments) { [meta[:app_id], meta[:for][:valid_cpu]]}

        it_behaves_like "a method with a configurable request"
      end
    end

    context "router" do
      let(:response) { endpoint.for(meta[:app_id], meta[:for][:valid_router]) }
      let(:stub_pattern) { "for-valid-router-404" }

      it_behaves_like "a not found response"
    end

    context "invalid" do
      let(:response) { endpoint.for(meta[:app_id], meta[:for][:invalid]) }
      let(:stub_pattern) { "for-invalid-400" }

      it_behaves_like "a client error"
    end
  end
end
