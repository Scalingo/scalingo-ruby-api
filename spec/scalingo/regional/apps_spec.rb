require "spec_helper"

RSpec.describe Scalingo::Regional::Apps, type: :endpoint do
  describe "all" do
    subject(:response) { instance.all(**arguments) }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:get, api_path.merge("/apps")) }
  end

  describe "create" do
    subject(:response) { instance.create(**arguments) }

    let(:body) { {field: "value"} }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:post, api_path.merge("/apps")).with(body: {app: body}) }

    context "when dry-running" do
      let(:params) { {dry_run: true} }

      it { is_expected.to have_requested(:post, api_path.merge("/apps")).with(headers: {"X-Dry-Run" => true}, body: {app: body}) }
    end
  end

  describe "find" do
    subject(:response) { instance.find(**arguments) }

    let(:params) { {id: "my-app-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id")) }
  end

  describe "logs_url" do
    subject(:response) { instance.logs_url(**arguments) }

    let(:params) { {id: "my-app-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/logs")) }
  end

  describe "update" do
    subject(:response) { instance.update(**arguments) }

    let(:params) { {id: "my-app-id"} }
    let(:body) { {field: "value"} }

    include_examples "requires authentication"
    include_examples "requires some params", :id

    it { is_expected.to have_requested(:patch, api_path.merge("/apps/my-app-id")).with(body: {app: body}) }
  end

  describe "rename" do
    subject(:response) { instance.rename(**arguments) }

    let(:params) { {id: "my-app-id"} }
    let(:body) { {field: "value"} }

    include_examples "requires authentication"
    include_examples "requires some params", :id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/rename")).with(body: body) }
  end

  describe "transfer" do
    subject(:response) { instance.transfer(**arguments) }

    let(:params) { {id: "my-app-id"} }
    let(:body) { {field: "value"} }

    include_examples "requires authentication"
    include_examples "requires some params", :id

    it { is_expected.to have_requested(:patch, api_path.merge("/apps/my-app-id")).with(body: body) }
  end

  describe "destroy" do
    subject(:response) { instance.destroy(**arguments) }

    let(:params) { {id: "my-app-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :id

    it { is_expected.to have_requested(:delete, api_path.merge("/apps/my-app-id")) }
  end
end
