require "spec_helper"

RSpec.describe Scalingo::Auth::ScmIntegrations do
  let(:endpoint) { auth.scm_integrations }

  context "all" do
    let(:response) { endpoint.all }
    let(:expected_count) { 2 }
    let(:stub_pattern) { "all" }

    it_behaves_like "a collection response"
    it_behaves_like "a non-paginated collection"
  end

  context "create" do
    context "success" do
      let(:response) {
        endpoint.create(
          scm_type: "gitlab-self-hosted",
          url: "https://gitlab.example.com",
          access_token: "e9740ca2466cf4da5e6c3a9e79a64f84bdf4b3b2"
        )
      }

      let(:stub_pattern) { "create-201" }

      it_behaves_like "a successful response", 201
    end

    context "failure" do
      let(:response) { endpoint.create(key: :value) }

      let(:stub_pattern) { "create-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  context "show" do
    let(:response) { endpoint.show("5bb2e877-9e5c-a83f-8e0e-7c75eebf212c") }

    context "success" do
      let(:stub_pattern) { "show-200" }

      it_behaves_like "a successful response"
    end

    context "not found" do
      let(:stub_pattern) { "show-404" }

      it_behaves_like "a not found response"
    end
  end

  context "destroy" do
    let(:response) { endpoint.destroy("5bb2e877-9e5c-a83f-8e0e-7c75eebf212c") }

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
