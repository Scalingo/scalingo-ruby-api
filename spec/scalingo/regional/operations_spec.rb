require "spec_helper"

RSpec.describe Scalingo::Regional::Operations do
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
end
