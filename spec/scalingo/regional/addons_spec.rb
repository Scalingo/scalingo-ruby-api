require "spec_helper"

RSpec.describe Scalingo::Regional::Addons do
  describe_method "categories" do
    context "guest" do
      subject { guest_endpoint }

      let(:expected_count) { 2 }
      let(:stub_pattern) { "categories-guest" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end

    context "logged" do
      let(:expected_count) { 2 }
      let(:stub_pattern) { "categories-logged" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  describe_method "providers" do
    context "guest" do
      subject { guest_endpoint }

      let(:expected_count) { 9 }
      let(:stub_pattern) { "providers-guest" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end

    context "logged" do
      let(:expected_count) { 11 }
      let(:stub_pattern) { "providers-logged" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  describe_method "provision" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:provision][:valid]] }
      let(:stub_pattern) { "provision-201" }
      let(:expected_keys) { %i[addon message] }

      it_behaves_like "a singular object response", 201
    end

    context "failure" do
      let(:arguments) { [meta[:app_id], meta[:provision][:invalid]] }
      let(:stub_pattern) { "provision-400" }

      it_behaves_like "a client error"
    end
  end

  describe_method "for" do
    context "success" do
      let(:arguments) { meta[:app_id] }
      let(:stub_pattern) { "for-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  describe_method "find" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:id]] }
      let(:stub_pattern) { "find-200" }

      it_behaves_like "a singular object response"
    end

    context "not found" do
      let(:arguments) { [meta[:app_id], meta[:not_found_id]] }
      let(:stub_pattern) { "find-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "sso" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:id]] }
      let(:stub_pattern) { "sso-200" }

      it_behaves_like "a singular object response"
    end

    context "not found" do
      let(:arguments) { [meta[:app_id], meta[:not_found_id]] }
      let(:stub_pattern) { "sso-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "token" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:id]] }
      let(:stub_pattern) { "token-200" }

      it_behaves_like "a singular object response"
    end

    context "not found" do
      let(:arguments) { [meta[:app_id], meta[:not_found_id]] }
      let(:stub_pattern) { "token-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "authenticate!" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:id]] }
      let(:stub_pattern) { "token-200" }

      it_behaves_like "a singular object response"
      it "authenticates" do
        response
        expect(scalingo.authenticated_for_database?(meta[:id])).to be true
      end
    end

    context "not found" do
      let(:arguments) { [meta[:app_id], meta[:not_found_id]] }
      let(:stub_pattern) { "token-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "update" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:id], meta[:update][:valid]] }
      let(:stub_pattern) { "update-200" }
      let(:expected_keys) { %i[addon message] }

      it_behaves_like "a singular object response"
    end

    context "failure" do
      let(:arguments) { [meta[:app_id], meta[:id], meta[:update][:invalid]] }
      let(:stub_pattern) { "update-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "destroy" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:id]] }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "an empty response"
    end

    context "not found" do
      let(:arguments) { [meta[:app_id], meta[:not_found_id]] }
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end
  end
end
