require "spec_helper"

RSpec.describe Scalingo::Auth::Keys do
  let(:endpoint) { auth.keys }

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

    context "unprocessable" do
      let(:response) { endpoint.create(meta[:create][:invalid]) }
      let(:stub_pattern) { "create-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  context "show" do
    context "success" do
      let(:response) { endpoint.show(meta[:id]) }
      let(:stub_pattern) { "show-200" }

      it_behaves_like "a successful response"

      context "request customization" do
        let(:method_name) { "show" }
        let(:valid_arguments) { meta[:id] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "not found" do
      let(:response) { endpoint.show(meta[:not_found_id]) }
      let(:stub_pattern) { "show-404" }

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
