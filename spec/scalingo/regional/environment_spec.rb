require "spec_helper"

RSpec.describe Scalingo::Regional::Environment, type: :endpoint do
  let(:app_id) { "my-app-id" }

  describe "list" do
    subject(:response) { instance.list(**arguments) }

    let(:params) { {app_id: app_id} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/variables")) }
  end

  describe "create" do
    subject(:response) { instance.create(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { {field: "value"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/variables")).with(body: {variable: body}) }
  end

  describe "update" do
    subject(:response) { instance.update(**arguments) }

    let(:params) { {app_id: app_id, id: "variable-id"} }
    let(:body) { {field: "value"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id, :id

    it { is_expected.to have_requested(:put, api_path.merge("/apps/my-app-id/variables/variable-id")).with(body: {variable: body}) }
  end

  describe "bulk_update" do
    subject(:response) { instance.bulk_update(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { [{field: "value"}] }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:put, api_path.merge("/apps/my-app-id/variables")).with(body: {variables: body}) }
  end

  describe "delete" do
    subject(:response) { instance.delete(**arguments) }

    let(:params) { {app_id: app_id, id: "variable-id"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id, :id

    it { is_expected.to have_requested(:delete, api_path.merge("/apps/my-app-id/variables/variable-id")) }
  end

  describe "bulk_destroy" do
    subject(:response) { instance.bulk_destroy(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { [1, 2, 3] }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :app_id

    it { is_expected.to have_requested(:delete, api_path.merge("/apps/my-app-id/variables")).with(body: {variable_ids: body}) }
  end
end
