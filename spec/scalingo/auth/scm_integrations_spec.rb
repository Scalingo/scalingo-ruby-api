require "spec_helper"

RSpec.describe Scalingo::Auth::ScmIntegrations do
  describe_method "all" do
    let(:stub_pattern) { "all-200" }

    it_behaves_like "a collection response"
    it_behaves_like "a non-paginated collection"
  end

  describe_method "create" do
    context "success" do
      let(:body) { meta[:create][:valid] }
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a singular object response", 201
    end

    context "failure" do
      let(:body) { meta[:create][:invalid] }
      let(:stub_pattern) { "create-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  describe_method "show" do
    context "success" do
      let(:params) { {id: meta[:id]} }
      let(:stub_pattern) { "show-200" }

      it_behaves_like "a singular object response"
    end

    context "not found" do
      let(:params) { {id: meta[:not_found_id]} }
      let(:stub_pattern) { "show-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "destroy" do
    context "success" do
      let(:params) { {id: meta[:id]} }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "an empty response"
    end

    context "not found" do
      let(:params) { {id: meta[:not_found_id]} }
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end
  end
end
