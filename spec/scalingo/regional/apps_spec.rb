require "spec_helper"

RSpec.describe Scalingo::Regional::Apps do
  let(:endpoint) { regional.apps }

  context "all" do
    let(:response) { endpoint.all }
    let(:expected_count) { 2 }
    let(:stub_pattern) { "all" }

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

    context "failure" do
      let(:response) { endpoint.create(meta[:create][:invalid]) }
      let(:stub_pattern) { "create-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  context "find" do
    context "success" do
      let(:response) { endpoint.find(meta[:id]) }
      let(:stub_pattern) { "find-200" }

      it_behaves_like "a successful response"

      context "request customization" do
        let(:method_name) { "find" }
        let(:valid_arguments) { meta[:id] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "not found" do
      let(:response) { endpoint.find(meta[:not_found_id]) }
      let(:stub_pattern) { "find-404" }

      it_behaves_like "a not found response"
    end
  end

  context "update" do
    context "success" do
      let(:response) { endpoint.update(meta[:id], meta[:update][:valid]) }
      let(:stub_pattern) { "update-200" }

      it_behaves_like "a successful response"

      context "request customization" do
        let(:method_name) { "update" }
        let(:valid_arguments) { [meta[:id], meta[:update][:valid]] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "invalid stack" do
      let(:response) { endpoint.update(meta[:id], meta[:update][:invalid]) }
      let(:stub_pattern) { "update-stack-404" }

      it_behaves_like "a not found response"
    end
  end

  context "logs_url" do
    context "success" do
      let(:response) { endpoint.logs_url(meta[:id]) }
      let(:stub_pattern) { "logs_url" }

      it_behaves_like "a successful response"

      context "request customization" do
        let(:method_name) { "logs_url" }
        let(:valid_arguments) { meta[:id] }

        it_behaves_like "a method with a configurable request"
      end
    end
  end

  context "destroy" do
    context "success" do
      let(:response) { endpoint.destroy(meta[:id], meta[:destroy][:valid]) }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "a successful response", 204

      context "request customization" do
        let(:method_name) { "destroy" }
        let(:valid_arguments) { [meta[:id], meta[:destroy][:valid]] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "not found" do
      let(:response) { endpoint.destroy(meta[:not_found_id], meta[:destroy][:valid]) }
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end

    context "unprocessable" do
      let(:response) { endpoint.destroy(meta[:id], meta[:destroy][:invalid]) }
      let(:stub_pattern) { "destroy-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  context "rename" do
    context "success" do
      let(:response) { endpoint.rename(meta[:id], meta[:rename][:valid]) }
      let(:stub_pattern) { "rename-200" }

      it_behaves_like "a successful response"

      context "request customization" do
        let(:method_name) { "rename" }
        let(:valid_arguments) { [meta[:id], meta[:rename][:valid]] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "not found" do
      let(:response) { endpoint.rename(meta[:not_found_id], meta[:rename][:valid]) }
      let(:stub_pattern) { "rename-404" }

      it_behaves_like "a not found response"
    end

    context "unprocessable" do
      let(:response) { endpoint.rename(meta[:id], meta[:rename][:invalid]) }
      let(:stub_pattern) { "rename-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  context "transfer" do
    context "success" do
      let(:response) { endpoint.transfer(meta[:id], meta[:transfer][:valid]) }
      let(:stub_pattern) { "transfer-200" }

      it_behaves_like "a successful response"

      context "request customization" do
        let(:method_name) { "transfer" }
        let(:valid_arguments) { [meta[:id], meta[:transfer][:valid]] }

        it_behaves_like "a method with a configurable request"
      end
    end

    context "not found" do
      let(:response) { endpoint.transfer(meta[:not_found_id], meta[:transfer][:valid]) }
      let(:stub_pattern) { "transfer-404" }

      it_behaves_like "a not found response"
    end

    context "unprocessable" do
      let(:response) { endpoint.transfer(meta[:id], meta[:transfer][:invalid]) }
      let(:stub_pattern) { "transfer-422" }

      it_behaves_like "an unprocessable request"
    end
  end
end
