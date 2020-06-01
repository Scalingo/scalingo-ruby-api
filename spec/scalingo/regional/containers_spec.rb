require "spec_helper"

RSpec.describe Scalingo::Regional::Containers do
  let(:endpoint) { regional.containers }
  let(:guest_endpoint) { regional_guest.containers }

  context "sizes" do
    context "guest" do
      let(:response) { guest_endpoint.sizes }
      let(:expected_count) { 7 }
      let(:stub_pattern) { "sizes-guest" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end

    context "logged" do
      let(:response) { endpoint.sizes }
      let(:expected_count) { 7 }
      let(:stub_pattern) { "sizes-logged" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"

      context "request customization" do
        let(:method_name) { "sizes" }

        it_behaves_like "a method with a configurable request"
      end
    end
  end

  context "for" do
    context "success" do
      let(:response) { endpoint.for(meta[:app_id]) }
      let(:expected_count) { 2 }
      let(:stub_pattern) { "for-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"

      context "request customization" do
        let(:method_name) { "for" }
        let(:valid_arguments) { meta[:app_id] }

        it_behaves_like "a method with a configurable request"
      end
    end
  end

  context "restart" do
    context "success" do
      let(:response) { endpoint.restart(meta[:app_id], meta[:restart][:valid]) }
      let(:stub_pattern) { "restart-202" }

      it_behaves_like "a successful response", 202

      context "request customization" do
        let(:method_name) { "restart" }
        let(:valid_arguments) { [meta[:app_id], meta[:restart][:valid]] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "success" do
      let(:response) { endpoint.restart(meta[:app_id], meta[:restart][:invalid]) }
      let(:stub_pattern) { "restart-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  context "scale" do
    context "success" do
      let(:response) { endpoint.scale(meta[:app_id], meta[:scale][:valid]) }
      let(:stub_pattern) { "scale-202" }

      it_behaves_like "a successful response", 202

      context "request customization" do
        let(:method_name) { "scale" }
        let(:valid_arguments) { [meta[:app_id], meta[:scale][:valid]] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "success" do
      let(:response) { endpoint.scale(meta[:app_id], meta[:scale][:invalid]) }
      let(:stub_pattern) { "scale-422" }

      it_behaves_like "an unprocessable request"
    end
  end
end
