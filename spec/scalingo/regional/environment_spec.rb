require "spec_helper"

RSpec.describe Scalingo::Regional::Environment do
  describe_method "for" do
    context "success" do
      let(:arguments) { meta[:app_id] }
      let(:stub_pattern) { "for-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  describe_method "create" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:create][:valid]] }
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a singular object response", 201
    end

    context "failure" do
      let(:arguments) { [meta[:app_id], meta[:create][:invalid]] }
      let(:stub_pattern) { "create-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  describe_method "update" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:id], meta[:update][:valid]] }
      let(:stub_pattern) { "update-200" }

      it_behaves_like "a singular object response"
    end

    context "not found" do
      let(:arguments) { [meta[:app_id], meta[:not_found_id], meta[:update][:valid]] }
      let(:stub_pattern) { "update-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "bulk_update" do
    let(:arguments) { [meta[:app_id], meta[:update][:bulk]] }
    let(:expected_count) { 4 }
    let(:stub_pattern) { "bulk-update-200" }

    it_behaves_like "a collection response"
    it_behaves_like "a non-paginated collection"
  end

  describe_method "destroy" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:id]] }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "an empty response"
    end

    context "not found" do
      let(:arguments) { [meta[:app_id], meta[:not_found_id]] }
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "bulk_destroy" do
    let(:arguments) { [meta[:app_id], meta[:destroy][:bulk]] }
    let(:stub_pattern) { "bulk-destroy-204" }

    it_behaves_like "an empty response"
  end
end
