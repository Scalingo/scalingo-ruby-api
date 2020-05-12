require "spec_helper"

RSpec.describe Scalingo::Auth::User do
  let(:endpoint) { auth.user }

  context "self" do
    let(:response) { endpoint.self }
    let(:stub_pattern) { "self" }

    it_behaves_like "a successful response"
  end

  context "update" do
    let(:response) { endpoint.update(email: "email@email.email")  }

    context "success" do
      let(:stub_pattern) { "update" }

      it_behaves_like "a successful response"
    end
  end
end
