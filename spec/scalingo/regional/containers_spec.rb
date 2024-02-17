require "spec_helper"

RSpec.describe Scalingo::Regional::Containers, type: :endpoint do
  let(:app_id) { "my-app-id" }

  describe "sizes" do
    subject(:response) { instance.sizes(**arguments) }

    it { is_expected.to have_requested(:get, api_path.merge("/features/container_sizes")) }
  end

  describe "for" do
    subject(:response) { instance.for(**arguments) }

    let(:params) { {app_id: app_id} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/containers")) }
  end

  describe "scale" do
    subject(:response) { instance.scale(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { {field: "value"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/scale")).with(body: {containers: body}) }
  end

  describe "restart" do
    subject(:response) { instance.restart(**arguments) }

    let(:params) { {app_id: app_id} }
    let(:body) { {field: "value"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id

    it { is_expected.to have_requested(:post, api_path.merge("/apps/my-app-id/restart")).with(body: {scope: body}) }
  end
end
