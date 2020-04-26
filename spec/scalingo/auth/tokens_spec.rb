require "spec_helper"

RSpec.describe Scalingo::Auth::Tokens do
  before do
    stub_request(:any, /auth.scalingo.com\/v1/).to_rack(Scalingo::Mocks::Auth::API)
  end

  let(:guest_client) { Scalingo::Client.new.auth.tokens }

  let(:client) {
    client = Scalingo::Client.new
    client.authenticate_with(bearer_token: Scalingo::Mocks::Auth::VALID_BEARER_TOKEN)
    client.auth.tokens
  }

  context "exchange" do
    subject { guest_client }

    it "should be succesful with a valid token" do
      response = subject.exchange(token: Scalingo::Mocks::Auth::VALID_ACCESS_TOKEN)

      expect(response).to be_successful
      expect(response.data[:token]).to be_present
    end

    it "should be rejected with an valid token" do
      response = subject.exchange(token: "other")

      expect(response.status).to eq 401
    end
  end

  context "all" do
    let(:response) { client.all }
    let(:expected_count) { 2 }

    it_behaves_like "a collection response"
    it_behaves_like "a non-paginated collection"
  end

  context "create" do
    let(:response) { client.create(name: "Test Token") }

    it "should create a token" do
      expect(response).to be_successful
      expect(response.status).to eq 201
    end
  end

  context "renew" do
    let(:response) { client.renew("00ac4742-8ff5-4306-932f-3078e28ecaff") }

    it "should renew the token" do
      expect(response).to be_successful
      expect(response.status).to eq 200
    end
  end

  context "destroy" do
    let(:response) { client.destroy("00ac4742-8ff5-4306-932f-3078e28ecaff") }

    it "should destroy the token" do
      expect(response).to be_successful
      expect(response.status).to eq 204
    end
  end
end
