require "spec_helper"

RSpec.describe Scalingo::Auth::Tokens do
  let(:guest_client) { Scalingo::Client.new.auth.tokens }

  let(:client) {
    client = Scalingo::Client.new
    client.authenticate_with(bearer_token: Scalingo::VALID_BEARER_TOKEN)
    client.auth.tokens
  }

  context "exchange" do
    subject { guest_client }

    context "with a valid token" do
      let(:stub_pattern) { "exchange-200" }

      it "should be succesful" do
        response = subject.exchange(token: Scalingo::VALID_ACCESS_TOKEN)

        expect(response).to be_successful
        expect(response.data[:token]).to be_present
      end
    end

    context "with an invalid token" do
      let(:stub_pattern) { "exchange-401" }

      it "should be rejected with an valid token" do
        response = subject.exchange(token: "other")

        expect(response.status).to eq 401
      end
    end
  end

  context "all" do
    let(:response) { client.all }
    let(:expected_count) { 2 }
    let(:stub_pattern) { "all" }

    it_behaves_like "a collection response"
    it_behaves_like "a non-paginated collection"
  end

  context "create" do
    let(:response) { client.create(name: "Test Token") }

    context "success" do
      let(:stub_pattern) { "create" }

      it_behaves_like "a successful response", 201
    end
  end

  context "renew" do
    let(:response) { client.renew("00ac4742-8ff5-4306-932f-3078e28ecaff") }

    context "success" do
      let(:stub_pattern) { "renew-200" }

      it_behaves_like "a successful response"
    end

    context "not found" do
      let(:stub_pattern) { "renew-404" }

      it_behaves_like "a not found response"
    end
  end

  context "destroy" do
    let(:response) { client.destroy("00ac4742-4306-932f-8ff5-3078e28ecaff") }

    context "success" do
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "a successful response", 204
    end

    context "not found" do
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end
  end
end
