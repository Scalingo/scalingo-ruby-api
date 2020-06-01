require "spec_helper"

RSpec.describe Scalingo::Regional::Notifiers do
  let(:endpoint) { regional.notifiers }
  let(:guest_endpoint) { regional_guest.notifiers }

  context "platforms" do
    context "guest" do
      let(:response) { guest_endpoint.platforms }
      let(:expected_count) { 4 }
      let(:stub_pattern) { "platforms-guest" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end

    context "logged" do
      let(:response) { endpoint.platforms }
      let(:expected_count) { 4 }
      let(:stub_pattern) { "platforms-logged" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"

      context "request customization" do
        let(:method_name) { "platforms" }

        it_behaves_like "a method with a configurable request"
      end
    end
  end

  context "for" do
    context "success" do
      let(:response) { endpoint.for(meta[:app_id]) }
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

  context "find" do
    context "success" do
      let(:response) { endpoint.find(meta[:app_id], meta[:id]) }
      let(:stub_pattern) { "find-200" }

      it_behaves_like "a successful response"

      context "request customization" do
        let(:method_name) { "find" }
        let(:valid_arguments) { [meta[:app_id], meta[:id]] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "not found" do
      let(:response) { endpoint.find(meta[:app_id], meta[:not_found_id]) }
      let(:stub_pattern) { "find-404" }

      it_behaves_like "a not found response"
    end
  end

  context "create" do
    context "success" do
      let(:response) { endpoint.create(meta[:app_id], meta[:create][:valid]) }
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a successful response", 201

      context "request customization" do
        let(:method_name) { "create" }
        let(:valid_arguments) { [meta[:app_id], meta[:create][:valid]]}

        it_behaves_like "a method with a configurable request"
      end
    end

    context "not found" do
      let(:response) { endpoint.create(meta[:app_id], meta[:create][:not_found]) }
      let(:stub_pattern) { "create-404" }

      it_behaves_like "a not found response"
    end

    context "failure" do
      let(:response) { endpoint.create(meta[:app_id], meta[:create][:invalid]) }
      let(:stub_pattern) { "create-422" }

      it_behaves_like "an unprocessable request"
    end
  end


  context "test" do
    context "success" do
      let(:response) { endpoint.test(meta[:app_id], meta[:id]) }
      let(:stub_pattern) { "test-200" }

      it_behaves_like "a successful response"

      context "request customization" do
        let(:method_name) { "test" }
        let(:valid_arguments) { [meta[:app_id], meta[:id]] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "not found" do
      let(:response) { endpoint.test(meta[:app_id], meta[:not_found_id]) }
      let(:stub_pattern) { "test-404" }

      it_behaves_like "a not found response"
    end
  end

  context "update" do
    context "success" do
      let(:response) { endpoint.update(meta[:app_id], meta[:id], meta[:update][:valid]) }
      let(:stub_pattern) { "update-200" }

      it_behaves_like "a successful response"

      context "request customization" do
        let(:method_name) { "update" }
        let(:valid_arguments) { [meta[:app_id], meta[:id], meta[:update][:valid]]}

        it_behaves_like "a method with a configurable request"
      end
    end
  end

  context "destroy" do
    context "success" do
      let(:response) { endpoint.destroy(meta[:app_id], meta[:id]) }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "a successful response", 204

      context "request customization" do
        let(:method_name) { "destroy" }
        let(:valid_arguments) { [meta[:app_id], meta[:id]] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "not found" do
      let(:response) { endpoint.destroy(meta[:app_id], meta[:not_found_id]) }
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end
  end
end
