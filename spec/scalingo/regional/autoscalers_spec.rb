require "spec_helper"

RSpec.describe Scalingo::Regional::Autoscalers, type: :endpoint do
  let(:app_id) { "my-app-id" }

  describe "list" do
    subject(:response) { instance.list(**arguments) }

    let(:params) { {app_id: app_id} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/autoscalers")) }
  end

  describe "create" do
    subject(:response) { instance.create(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { {field: "value"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/autoscalers")).with(body: {autoscaler: body}) }
  end

  describe "find" do
    subject(:response) { instance.find(**arguments) }

    let(:params) { {app_id: app_id, id: "autoscaler-id"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id, :id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/autoscalers/autoscaler-id")) }
  end

  describe "update" do
    subject(:response) { instance.update(**arguments) }

    let(:params) { {app_id: app_id, id: "autoscaler-id"} }
    let(:body) { {field: "value"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id, :id

    it { is_expected.to have_requested(:put, api_path.merge("/apps/my-app-id/autoscalers/autoscaler-id")).with(body: {autoscaler: body}) }
  end

  describe "delete" do
    subject(:response) { instance.delete(**arguments) }

    let(:params) { {app_id: app_id, id: "autoscaler-id"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id, :id

    it { is_expected.to have_requested(:delete, api_path.merge("/apps/my-app-id/autoscalers/autoscaler-id")) }
  end
end
