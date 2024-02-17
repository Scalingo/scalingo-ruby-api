require "spec_helper"

RSpec.describe Scalingo::Regional::Addons, type: :endpoint do
  let(:app_id) { "my-app-id" }

  describe "providers" do
    subject(:response) { instance.providers(**arguments) }

    it { is_expected.to have_requested(:get, api_path.merge("/addon_providers")) }
  end

  describe "categories" do
    subject(:response) { instance.categories(**arguments) }

    it { is_expected.to have_requested(:get, api_path.merge("/addon_categories")) }
  end

  describe "for" do
    subject(:response) { instance.for(**arguments) }

    let(:params) { {app_id: app_id} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/addons")) }
  end

  describe "provision" do
    subject(:response) { instance.provision(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { {field: "value"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/addons")).with(body: {addon: body}) }
  end

  describe "find" do
    subject(:response) { instance.find(**arguments) }

    let(:params) { {app_id: app_id, id: "addon-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/addons/addon-id")) }
  end

  describe "update" do
    subject(:response) { instance.update(**arguments) }

    let(:params) { {app_id: app_id, id: "addon-id"} }
    let(:body) { {field: "value"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:patch, api_path.merge("/apps/my-app-id/addons/addon-id")).with(body: {addon: body}) }
  end

  describe "sso" do
    subject(:response) { instance.sso(**arguments) }

    let(:params) { {app_id: app_id, id: "addon-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/addons/addon-id/sso")) }
  end

  describe "token" do
    subject(:response) { instance.token(**arguments) }

    let(:params) { {app_id: app_id, id: "addon-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/addons/addon-id/token")) }
  end

  describe "destroy" do
    subject(:response) { instance.destroy(**arguments) }

    let(:params) { {app_id: app_id, id: "addon-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:delete, api_path.merge("/apps/my-app-id/addons/addon-id")) }
  end
end
