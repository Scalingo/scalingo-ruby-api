require "spec_helper"

RSpec.describe Scalingo::Regional::Collaborators, type: :endpoint do
  let(:app_id) { "my-app-id" }

  describe "for" do
    subject(:response) { instance.for(**arguments) }

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

  describe "invite" do
    subject(:response) { instance.invite(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { {field: "value"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/collaborators")).with(body: {collaborator: body}) }
  end

  describe "destroy" do
    subject(:response) { instance.destroy(**arguments) }

    let(:params) { {app_id: app_id, id: "collaborator-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:delete, api_path.merge("/apps/my-app-id/collaborators/collaborator-id")) }
  end
end
