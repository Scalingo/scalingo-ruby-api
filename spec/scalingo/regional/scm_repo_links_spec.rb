require "spec_helper"

RSpec.describe Scalingo::Regional::ScmRepoLinks do
  let(:endpoint) { regional.scm_repo_links }

  context "show" do
    context "success" do
      let(:response) { endpoint.show(meta[:app_id]) }
      let(:stub_pattern) { "show-200" }

      it_behaves_like "a successful response"
    end
  end

  context "create" do
    context "success" do
      let(:response) { endpoint.create(meta[:app_id], meta[:create][:valid]) }
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a successful response", 201
    end
  end

  context "update" do
    context "success" do
      let(:response) { endpoint.update(meta[:app_id], meta[:update][:valid]) }
      let(:stub_pattern) { "update-200" }

      it_behaves_like "a successful response"
    end
  end

  context "manual deploy" do
    context "success" do
      let(:response) { endpoint.deploy(meta[:app_id], meta[:deploy][:valid]) }
      let(:stub_pattern) { "manual-deploy-200" }

      it_behaves_like "a successful response"
    end
  end

  context "destroy" do
    context "success" do
      let(:response) { endpoint.destroy(meta[:app_id]) }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "a successful response", 204
    end
  end
end
