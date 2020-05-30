require "spec_helper"

RSpec.describe Scalingo::Regional::Domains do
  let(:endpoint) { regional.domains }

  context "for" do
    context "success" do
      let(:response) { endpoint.for(meta[:app_id]) }
      let(:stub_pattern) { "for-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  context "find" do
    context "success" do
      let(:response) { endpoint.find(meta[:app_id], meta[:id]) }
      let(:stub_pattern) { "find-200" }

      it_behaves_like "a successful response"
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
    end

    context "not found" do
      let(:response) { endpoint.update(meta[:app_id], meta[:not_found_id], meta[:update][:valid]) }
      let(:stub_pattern) { "update-404" }

      it_behaves_like "a not found response"
    end

    context "failure" do
      let(:response) { endpoint.update(meta[:app_id], meta[:id], meta[:update][:invalid]) }
      let(:stub_pattern) { "update-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  context "destroy" do
    context "success" do
      let(:response) { endpoint.destroy(meta[:app_id], meta[:id]) }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "a successful response", 204
    end

    context "not found" do
      let(:response) { endpoint.destroy(meta[:app_id], meta[:not_found_id]) }
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end
  end
end
