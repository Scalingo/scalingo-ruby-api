require "spec_helper"

RSpec.describe Scalingo::Auth::Tokens do
  let(:endpoint) { auth.tokens }

  context "exchange" do
    subject { auth_guest.tokens }

    context "with a valid token" do
      let(:response) { subject.exchange(meta[:exchange][:valid]) }
      let(:stub_pattern) { "exchange-200" }

      it "should be successful" do
        expect(response).to be_successful
        expect(response.data[:token]).to be_present
      end

      context "request customization" do
        let(:method_name) { "exchange" }
        let(:valid_arguments) { meta[:exchange][:valid] }
        let(:endpoint) { subject }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "with an invalid token" do
      let(:response) { subject.exchange(meta[:exchange][:invalid]) }
      let(:stub_pattern) { "exchange-401" }

      it "should be rejected with an valid token" do
        expect(response.status).to eq 401
      end
    end
  end

  context "all" do
    let(:response) { endpoint.all }
    let(:stub_pattern) { "all-200" }

    it_behaves_like "a collection response"
    it_behaves_like "a non-paginated collection"

    context "request customization" do
      let(:method_name) { "all" }

      it_behaves_like "a method with a configurable request"
    end
  end

  context "create" do
    context "success" do
      let(:response) { endpoint.create(meta[:create][:valid]) }
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a successful response", 201

      context "request customization" do
        let(:method_name) { "create" }
        let(:valid_arguments) { meta[:create][:valid] }

        it_behaves_like "a method with a configurable request"
      end
    end
  end

  context "renew" do
    context "success" do
      let(:response) { endpoint.renew(meta[:id]) }
      let(:stub_pattern) { "renew-200" }

      it_behaves_like "a successful response"

      context "request customization" do
        let(:method_name) { "renew" }
        let(:valid_arguments) { meta[:id] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "not found" do
      let(:response) { endpoint.renew(meta[:not_found_id]) }
      let(:stub_pattern) { "renew-404" }

      it_behaves_like "a not found response"
    end
  end

  context "destroy" do
    context "success" do
      let(:response) { endpoint.destroy(meta[:id]) }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "a successful response", 204

      context "request customization" do
        let(:method_name) { "destroy" }
        let(:valid_arguments) { meta[:id] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "not found" do
      let(:response) { endpoint.destroy(meta[:not_found_id]) }
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end
  end
end
