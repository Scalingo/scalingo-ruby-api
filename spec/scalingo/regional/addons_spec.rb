require "spec_helper"

RSpec.describe Scalingo::Regional::Addons do
  let(:endpoint) { regional.addons }
  let(:guest_endpoint) { regional_guest.addons }

  context "categories" do
    context "guest" do
      let(:response) { guest_endpoint.categories }
      let(:expected_count) { 2 }
      let(:stub_pattern) { "categories-guest" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end

    context "logged" do
      let(:response) { endpoint.categories }
      let(:expected_count) { 2 }
      let(:stub_pattern) { "categories-logged" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  context "providers" do
    context "guest" do
      let(:response) { guest_endpoint.providers }
      let(:expected_count) { 9 }
      let(:stub_pattern) { "providers-guest" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end

    context "logged" do
      let(:response) { endpoint.providers }
      let(:expected_count) { 11 }
      let(:stub_pattern) { "providers-logged" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  context "provision" do
    context "success" do
      let(:response) { endpoint.provision(meta[:app_id], meta[:provision][:valid]) }
      let(:stub_pattern) { "provision-201" }

      it_behaves_like "a successful response", 201
    end

    context "failure" do
      let(:response) { endpoint.provision(meta[:app_id], meta[:provision][:invalid]) }
      let(:stub_pattern) { "provision-400" }

      it_behaves_like "a client error"
    end
  end

  context "for" do
    context "success" do
      let(:response) { endpoint.for(meta[:app_id]) }
      let(:stub_pattern) { "for-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  context "find" do
    context "success" do
      let(:response) { endpoint.find(meta[:app_id], meta[:id]) }
      let(:stub_pattern) { "find-200" }

      it_behaves_like "a successful response"
    end

    context "not found" do
      let(:response) { endpoint.find(meta[:app_id], meta[:not_found_id]) }
      let(:stub_pattern) { "find-404" }

      it_behaves_like "a not found response"
    end
  end

  context "sso" do
    context "success" do
      let(:response) { endpoint.sso(meta[:app_id], meta[:id]) }
      let(:stub_pattern) { "sso-200" }

      it_behaves_like "a successful response"
    end

    context "not found" do
      let(:response) { endpoint.sso(meta[:app_id], meta[:not_found_id]) }
      let(:stub_pattern) { "sso-404" }

      it_behaves_like "a not found response"
    end
  end

  context "update" do
    context "success" do
      let(:response) { endpoint.update(meta[:app_id], meta[:id], meta[:update][:valid]) }
      let(:stub_pattern) { "update-200" }

      it_behaves_like "a successful response"
    end

    context "failure" do
      let(:response) { endpoint.update(meta[:app_id], meta[:id], meta[:update][:invalid]) }
      let(:stub_pattern) { "update-404" }

      it_behaves_like "a not found response"
    end
  end

  context "destroy" do
    context "success" do
      let(:response) { endpoint.destroy(meta[:app_id], meta[:id]) }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "a successful response", 204
    end

    context "not found" do
      let(:response) { endpoint.destroy(meta[:app_id], meta[:not_found_id]) }
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end
  end
end
