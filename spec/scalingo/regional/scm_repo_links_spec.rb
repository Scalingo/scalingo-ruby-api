require "spec_helper"

RSpec.describe Scalingo::Regional::ScmRepoLinks do
  describe_method "show" do
    context "success" do
      let(:params) { meta.slice(:app_id) }
      let(:stub_pattern) { "show-200" }

      it_behaves_like "a singular object response"
    end
  end

  describe_method "create" do
    context "success" do
      let(:params) { meta.slice(:app_id) }
      let(:body) { meta[:create][:valid] }
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a singular object response", 201
    end
  end

  describe_method "update" do
    context "success" do
      let(:params) { meta.slice(:app_id) }
      let(:body) { meta[:update][:valid] }
      let(:stub_pattern) { "update-200" }

      it_behaves_like "a singular object response"
    end
  end

  describe_method "deploy" do
    context "success" do
      let(:params) { meta.slice(:app_id) }
      let(:body) { meta[:deploy][:valid] }
      let(:stub_pattern) { "manual-deploy-200" }

      it_behaves_like "a singular object response"
    end
  end

  describe_method "destroy" do
    context "success" do
      let(:params) { meta.slice(:app_id) }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "an empty response"
    end
  end
end
