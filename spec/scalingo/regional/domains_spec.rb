require "spec_helper"

RSpec.describe Scalingo::Regional::Domains, type: :endpoint do
  let(:app_id) { "my-app-id" }

  describe "list" do
    subject(:response) { instance.list(**arguments) }

    let(:params) { {app_id: app_id} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/domains")) }
  end

  describe "create" do
    subject(:response) { instance.create(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { {field: "value"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/domains")).with(body: {domain: body}) }
  end

  describe "find" do
    subject(:response) { instance.find(**arguments) }

    let(:params) { {app_id: app_id, id: "domain-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/domains/domain-id")) }
  end

  describe "update" do
    subject(:response) { instance.update(**arguments) }

    let(:params) { {app_id: app_id, id: "domain-id"} }
    let(:body) { {field: "value"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:put, api_path.merge("/apps/my-app-id/domains/domain-id")).with(body: {domain: body}) }
  end

  describe "delete" do
    subject(:response) { instance.delete(**arguments) }

    let(:params) { {app_id: app_id, id: "domain-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:delete, api_path.merge("/apps/my-app-id/domains/domain-id")) }
  end
end
