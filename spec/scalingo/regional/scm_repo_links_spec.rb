require "spec_helper"

RSpec.describe Scalingo::Regional::ScmRepoLinks do
  describe_method "show" do
    context "success" do
      let(:arguments) { meta[:app_id] }
      let(:stub_pattern) { "show-200" }

      it_behaves_like "a successful response"
    end
  end

  describe_method "create" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:create][:valid]] }
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a successful response", 201
    end
  end

  describe_method "update" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:update][:valid]] }
      let(:stub_pattern) { "update-200" }

      it_behaves_like "a successful response"
    end
  end

  describe_method "deploy" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:deploy][:valid]] }
      let(:stub_pattern) { "manual-deploy-200" }

      it_behaves_like "a successful response"
    end
  end

  describe_method "destroy" do
    context "success" do
      let(:arguments) { meta[:app_id] }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "a successful response", 204
    end
  end
end
