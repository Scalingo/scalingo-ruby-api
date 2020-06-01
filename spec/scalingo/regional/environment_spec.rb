require "spec_helper"

RSpec.describe Scalingo::Regional::Environment do
  let(:endpoint) { regional.environment }

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

  context "create" do
    context "success" do
      let(:response) { endpoint.create(meta[:app_id], meta[:create][:valid]) }
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a successful response", 201

      context "request customization" do
        let(:method_name) { "create" }
        let(:valid_arguments) { [meta[:app_id], meta[:create][:valid]] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "failure" do
      let(:response) { endpoint.create(meta[:app_id], meta[:create][:invalid]) }
      let(:stub_pattern) { "create-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  context "update" do
    context "success" do
      let(:response) { endpoint.update(meta[:app_id], meta[:id], meta[:update][:valid]) }
      let(:stub_pattern) { "update-200" }

      it_behaves_like "a successful response"

      context "request customization" do
        let(:method_name) { "update" }
        let(:valid_arguments) { [meta[:app_id], meta[:id], meta[:update][:valid]] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "not found" do
      let(:response) { endpoint.update(meta[:app_id], meta[:not_found_id], meta[:update][:valid]) }
      let(:stub_pattern) { "update-404" }

      it_behaves_like "a not found response"
    end

    context "bulk-update" do
      let(:response) { endpoint.bulk_update(meta[:app_id], meta[:update][:bulk]) }
      let(:expected_count) { 4 }
      let(:stub_pattern) { "bulk-update-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"

      context "request customization" do
        let(:method_name) { "bulk_update" }
        let(:valid_arguments) { [meta[:app_id], meta[:update][:bulk]] }

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

    context "bulk" do
      let(:response) { endpoint.bulk_destroy(meta[:app_id], meta[:destroy][:bulk]) }
      let(:stub_pattern) { "bulk-destroy-204" }

      it_behaves_like "a successful response", 204

      context "request customization" do
        let(:method_name) { "bulk_destroy" }
        let(:valid_arguments) { [meta[:app_id], meta[:destroy][:bulk]] }

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
