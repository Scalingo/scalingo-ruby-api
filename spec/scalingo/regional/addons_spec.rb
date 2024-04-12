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

  describe "list" do
    subject(:response) { instance.list(**arguments) }

    let(:params) { {app_id: app_id} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/addons")) }
  end

  describe "create" do
    subject(:response) { instance.create(**arguments) }

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

    it { is_expected.to have_requested(:put, api_path.merge("/apps/my-app-id/addons/addon-id")).with(body: {addon: body}) }
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

    describe "database_client_for" do
      subject(:db_client) { instance.database_client_for(**params) }

      before do
        allow(Scalingo::Client::URLS).to receive(:fetch).with(:database).and_return({some_region: "http://localhost"})
      end

      context "with a valid response" do
        let(:token) { Scalingo.generate_test_jwt(duration: 1.hour) }

        before do
          stub_request(:post, "http://localhost/apps/my-app-id/addons/addon-id/token").to_return(
            body: {addon: {id: "addon-id", token: jwt}}.to_json,
            status: 200,
            headers: {content_type: "application/json"}
          )
        end

        it "returns a database client" do
          expect(subject).to be_a(Scalingo::Database)
          expect(subject).to be_authenticated
          expect(subject.token.value).to eq(jwt)
        end
      end

      context "with invalid params" do
        before do
          stub_request(:post, "http://localhost/apps/my-app-id/addons/addon-id/token").to_return(status: 404)
        end

        it "raises an exception" do
          expect { subject }.to raise_error(Faraday::ResourceNotFound)
        end
      end
    end
  end

  describe "delete" do
    subject(:response) { instance.delete(**arguments) }

    let(:params) { {app_id: app_id, id: "addon-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:delete, api_path.merge("/apps/my-app-id/addons/addon-id")) }
  end
end
