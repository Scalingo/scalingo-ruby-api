require "spec_helper"

RSpec.describe Scalingo::Regional::Deployments, type: :endpoint do
  let(:app_id) { "my-app-id" }

  describe "list" do
    subject(:response) { instance.list(**arguments) }

    let(:params) { {app_id: app_id} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/deployments")) }

    context "with query params" do
      let(:params) { {app_id: app_id, query: {page: 2}} }

      it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/deployments?page=2")) }
    end
  end

  describe "find" do
    subject(:response) { instance.find(**arguments) }

    let(:params) { {app_id: app_id, id: "deployment-id"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id, :id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/deployments/deployment-id")) }
  end

  describe "logs" do
    subject(:response) { instance.logs(**arguments) }

    let(:params) { {app_id: app_id, id: "deployment-id"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id, :id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/deployments/deployment-id/output")) }
  end
end
