require "spec_helper"

RSpec.describe Scalingo::Regional::ScmRepoLinks, type: :endpoint do
  let(:app_id) { "my-app-id" }

  describe "find" do
    subject(:response) { instance.find(**arguments) }

    let(:params) { {app_id: app_id} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/scm_repo_link")) }
  end

  describe "branches" do
    subject(:response) { instance.branches(**arguments) }

    let(:params) { {app_id: app_id} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/scm_repo_link/branches")) }
  end

  describe "pulls" do
    subject(:response) { instance.pulls(**arguments) }

    let(:params) { {app_id: app_id} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/scm_repo_link/pulls")) }
  end

  describe "create" do
    subject(:response) { instance.create(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { {field: "value"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/scm_repo_link")).with(body: {scm_repo_link: body}) }
  end

  describe "deploy" do
    subject(:response) { instance.deploy(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { {field: "value"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/scm_repo_link/manual_deploy")).with(body: body) }
  end

  describe "review_app" do
    subject(:response) { instance.review_app(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { {field: "value"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/scm_repo_link/manual_review_app")).with(body: body) }
  end

  describe "update" do
    subject(:response) { instance.update(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { {field: "value"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:put, api_path.merge("/apps/my-app-id/scm_repo_link")).with(body: {scm_repo_link: body}) }
  end

  describe "delete" do
    subject(:response) { instance.delete(**arguments) }

    let(:params) { {app_id: app_id} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:delete, api_path.merge("/apps/my-app-id/scm_repo_link")) }
  end
end
