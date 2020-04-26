require "spec_helper"

RSpec.describe Scalingo::Auth::Keys do
  before do
    stub_request(:any, /auth.scalingo.com\/v1/).to_rack(Scalingo::Mocks::Auth::API)
  end

  let(:client) {
    client = Scalingo::Client.new
    client.authenticate_with(bearer_token: Scalingo::Mocks::Auth::VALID_BEARER_TOKEN)
    client.auth.keys
  }

  context "all" do
    let(:response) { client.all }
    let(:expected_count) { 2 }

    it_behaves_like "a collection response"
    it_behaves_like "a non-paginated collection"
  end

  context "create" do
    let(:response) { client.create(name: "Key", content: "value") }

    it "should create a key" do
      expect(response).to be_successful
      expect(response.status).to eq 201
    end
  end

  context "show" do
    let(:response) { client.show("54dcde4a54636101231a0000") }

    it "should renew the key" do
      expect(response).to be_successful
      expect(response.status).to eq 200
    end
  end

  context "destroy" do
    let(:response) { client.destroy("54dcde4a54636101231a0000") }

    it "should destroy the key" do
      expect(response).to be_successful
      expect(response.status).to eq 204
    end
  end
end
