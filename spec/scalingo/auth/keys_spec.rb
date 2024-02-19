require "spec_helper"

RSpec.describe Scalingo::Auth::Keys, type: :endpoint do
  describe "list" do
    subject(:response) { instance.list(**arguments) }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:get, api_path.merge("/keys")) }
  end

  describe "create" do
    subject(:response) { instance.create(**arguments) }

    let(:body) { {field: "value"} }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:post, api_path.merge("/keys")).with(body: {key: body}) }
  end

  describe "find" do
    subject(:response) { instance.find(**arguments) }

    let(:params) { {id: "key-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :id

    it { is_expected.to have_requested(:get, api_path.merge("/keys/key-id")) }
  end

  describe "delete" do
    subject(:response) { instance.delete(**arguments) }

    let(:params) { {id: "key-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :id

    it { is_expected.to have_requested(:delete, api_path.merge("/keys/key-id")) }
  end
end
