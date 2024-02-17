require "spec_helper"

RSpec.describe Scalingo::Auth::ScmIntegrations, type: :endpoint do
  describe "all" do
    subject(:response) { instance.all(**arguments) }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:get, api_path.merge("/scm_integrations")) }
  end

  describe "create" do
    subject(:response) { instance.create(**arguments) }

    let(:body) { {field: "value"} }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:post, api_path.merge("/scm_integrations")).with(body: {scm_integration: body}) }
  end

  describe "show" do
    subject(:response) { instance.show(**arguments) }

    let(:params) { {id: "scm-integration-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :id

    it { is_expected.to have_requested(:get, api_path.merge("/scm_integrations/scm-integration-id")) }
  end

  describe "destroy" do
    subject(:response) { instance.destroy(**arguments) }

    let(:params) { {id: "scm-integration-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :id

    it { is_expected.to have_requested(:delete, api_path.merge("/scm_integrations/scm-integration-id")) }
  end
end
