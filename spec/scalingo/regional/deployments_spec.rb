require "spec_helper"

RSpec.describe Scalingo::Regional::Deployments do
  describe_method "for" do
    context "success" do
      let(:arguments) { [meta[:app_id], {}] }
      let(:stub_pattern) { "for-without-pages" }

      it_behaves_like "a collection response"
      it_behaves_like "a paginated collection"
    end
  end

  describe_method "find" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:id]] }
      let(:stub_pattern) { "find-200" }

      it_behaves_like "a successful response"
    end

    context "failure" do
      let(:arguments) { [meta[:app_id], meta[:not_found_id]] }
      let(:stub_pattern) { "find-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "logs" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:id]] }
      let(:stub_pattern) { "logs-200" }

      it_behaves_like "a successful response"
    end

    context "failure" do
      let(:arguments) { [meta[:app_id], meta[:not_found_id]] }
      let(:stub_pattern) { "logs-404" }

      it_behaves_like "a not found response"
    end
  end
end
