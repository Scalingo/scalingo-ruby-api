require "spec_helper"

RSpec.describe Scalingo::Auth::Tokens do
  describe_method "exchange" do
    subject { auth_guest.tokens }

    context "with a valid token" do
      let(:arguments) { meta[:exchange][:valid] }
      let(:stub_pattern) { "exchange-200" }

      it "should be successful" do
        expect(response).to be_successful
        expect(response.data[:token]).to be_present
      end
    end

    context "with an invalid token" do
      let(:arguments) { meta[:exchange][:invalid] }
      let(:stub_pattern) { "exchange-401" }

      it "should be rejected with an valid token" do
        expect(response.status).to eq 401
      end
    end
  end

  describe_method "all" do
    let(:stub_pattern) { "all-200" }

    it_behaves_like "a collection response"
    it_behaves_like "a non-paginated collection"
  end

  describe_method "create" do
    context "success" do
      let(:arguments) { meta[:create][:valid] }
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a singular object response", 201
    end
  end

  describe_method "renew" do
    context "success" do
      let(:arguments) { meta[:id] }
      let(:stub_pattern) { "renew-200" }

      it_behaves_like "a singular object response"
    end

    context "not found" do
      let(:arguments) { meta[:not_found_id] }
      let(:stub_pattern) { "renew-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "destroy" do
    context "success" do
      let(:arguments) { meta[:id] }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "an empty response"
    end

    context "not found" do
      let(:arguments) { meta[:not_found_id] }
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end
  end
end
