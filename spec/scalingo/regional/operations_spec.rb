require "spec_helper"

RSpec.describe Scalingo::Regional::Operations, type: :endpoint do
  let(:app_id) { "my-app-id" }

  describe "find" do
    subject(:response) { instance.find(**arguments) }

    let(:params) { {app_id: app_id, id: "op-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :app_id, :id

    it { is_expected.to have_requested(:get, api_path.merge("/apps/my-app-id/operations/op-id")) }
  end

  describe "fetch" do
    subject(:response) { instance.fetch("http://localhost/any-url") }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:get, "http://localhost/any-url") }
  end
end
