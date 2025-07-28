require "spec_helper"

RSpec.describe Scalingo::Regional::Collaborators, type: :endpoint do
  let(:app_id) { "my-app-id" }

  describe "list" do
    subject(:response) { instance.list(**arguments) }

    let(:params) { {app_id: app_id} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/collaborators")) }
  end

  describe "accept" do
    subject(:response) { instance.accept(**arguments) }

    let(:params) { {app_id: app_id, token: "some-token"} }

    include_examples "requires authentication"
    include_examples "requires some params", :token

    it { is_expected.to have_requested(:get, api_path.merge("/apps/collaboration?token=some-token")) }
  end

  describe "create" do
    subject(:response) { instance.create(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { {field: "value"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/collaborators")).with(body: {collaborator: body}) }
  end

  describe "delete" do
    subject(:response) { instance.delete(**arguments) }

    let(:params) { {app_id: app_id, id: "collaborator-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:delete, api_path.merge("/apps/my-app-id/collaborators/collaborator-id")) }
  end

  describe "update" do
    subject(:response) { instance.update(**arguments) }

    let(:params) { {app_id: app_id, id: "collaborator-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:patch, api_path.merge("/apps/my-app-id/collaborators/collaborator-id")) }
  end
end
