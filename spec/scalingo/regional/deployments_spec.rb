require "spec_helper"

RSpec.describe Scalingo::Regional::Deployments do
  let(:endpoint) { regional.deployments }

  context "for" do
    context "success" do
      let(:response) { endpoint.for(meta[:app_id]) }
      let(:stub_pattern) { "for-without-pages" }

      it_behaves_like "a collection response"
      it_behaves_like "a paginated collection"
    end
  end

  context "find" do
    context "success" do
      let(:response) { endpoint.find(meta[:app_id], meta[:id]) }
      let(:stub_pattern) { "find-200" }

      it_behaves_like "a successful response"
    end

    context "failure" do
      let(:response) { endpoint.find(meta[:app_id], meta[:not_found_id]) }
      let(:stub_pattern) { "find-404" }

      it_behaves_like "a not found response"
    end
  end

  context "logs" do
    context "success" do
      let(:response) { endpoint.logs(meta[:app_id], meta[:id]) }
      let(:stub_pattern) { "logs-200" }

      it_behaves_like "a successful response"
    end

    context "failure" do
      let(:response) { endpoint.logs(meta[:app_id], meta[:not_found_id]) }
      let(:stub_pattern) { "logs-404" }

      it_behaves_like "a not found response"
    end
  end
end
