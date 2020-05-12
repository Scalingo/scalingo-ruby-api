require "spec_helper"

RSpec.describe Scalingo::Auth::User do
  let(:client) {
    client = Scalingo::Client.new
    client.authenticate_with(bearer_token: Scalingo::VALID_BEARER_TOKEN)
    client.auth.user
  }

  context "self" do
    let(:response) { client.self }
    let(:stub_pattern) { "self" }

    it_behaves_like "a successful response"
  end

  context "update" do
    let(:response) { client.update(email: "email@email.email")  }

    context "success" do
      let(:stub_pattern) { "update" }

      it_behaves_like "a successful response"
    end
  end
end
