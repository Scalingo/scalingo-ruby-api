require "spec_helper"

RSpec.describe Scalingo::Regional::Notifiers, type: :endpoint do
  let(:app_id) { "my-app-id" }

  describe "platforms" do
    subject(:response) { instance.platforms(**arguments) }

    it { is_expected.to have_requested(:get, api_path.merge("/notification_platforms")) }
  end

  describe "list" do
    subject(:response) { instance.list(**arguments) }

    let(:params) { {app_id: app_id} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/notifiers")) }
  end

  describe "create" do
    subject(:response) { instance.create(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { {field: "value"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/notifiers")).with(body: {notifier: body}) }
  end

  describe "find" do
    subject(:response) { instance.find(**arguments) }

    let(:params) { {app_id: app_id, id: "notifier-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/notifiers/notifier-id")) }
  end

  describe "update" do
    subject(:response) { instance.update(**arguments) }

    let(:params) { {app_id: app_id, id: "notifier-id"} }
    let(:body) { {field: "value"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:put, api_path.merge("/apps/my-app-id/notifiers/notifier-id")).with(body: {notifier: body}) }
  end

  describe "test" do
    subject(:response) { instance.test(**arguments) }

    let(:params) { {app_id: app_id, id: "notifier-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/notifiers/notifier-id/test")) }
  end

  describe "delete" do
    subject(:response) { instance.delete(**arguments) }

    let(:params) { {app_id: app_id, id: "notifier-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:delete, api_path.merge("/apps/my-app-id/notifiers/notifier-id")) }
  end
end
