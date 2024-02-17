require "spec_helper"

RSpec.describe Scalingo::Auth::Tokens, type: :endpoint do
  describe "all" do
    subject(:response) { instance.all(**arguments) }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:get, api_path.merge("/tokens")) }
  end

  describe "create" do
    subject(:response) { instance.create(**arguments) }

    let(:body) { {field: "value"} }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:post, api_path.merge("/tokens")).with(body: {token: body}) }
  end

  describe "exchange" do
    subject(:response) { instance.exchange(**arguments) }

    let(:basic) { {user: nil, password: "yo"} }
    let(:expected_headers) do
      {"Authorization" => Faraday::Utils.basic_header_from(nil, "yo")}
    end

    it { is_expected.to have_requested(:post, api_path.merge("/tokens/exchange")).with(headers: expected_headers) }
  end

  describe "renew" do
    subject(:response) { instance.renew(**arguments) }

    let(:params) { {id: "token-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :id

    it { is_expected.to have_requested(:patch, api_path.merge("/tokens/token-id/renew")) }
  end

  describe "destroy" do
    subject(:response) { instance.destroy(**arguments) }

    let(:params) { {id: "token-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :id

    it { is_expected.to have_requested(:delete, api_path.merge("/tokens/token-id")) }
  end
end
