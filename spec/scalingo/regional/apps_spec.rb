require "spec_helper"

RSpec.describe Scalingo::Regional::Apps do
  let(:endpoint) { regional.apps }

  context "all" do
    let(:response) { endpoint.all }
    let(:expected_count) { 2 }
    let(:stub_pattern) { "all" }

    it_behaves_like "a collection response"
    it_behaves_like "a non-paginated collection"
  end

  context "create" do
    let(:response) { endpoint.create(name: "example-app") }

    context "success" do
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a successful response", 201
    end

    context "success" do
      let(:stub_pattern) { "create-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  context "find" do
    let(:response) { endpoint.find("51e938266edff4fac9100005") }

    context "success" do
      let(:stub_pattern) { "find-200" }

      it_behaves_like "a successful response"
    end

    context "not found" do
      let(:stub_pattern) { "find-404" }

      it_behaves_like "a not found response"
    end
  end

  context "update" do
    context "success" do
      let(:response) { endpoint.update("example-app", force_https: false) }
      let(:stub_pattern) { "update-200" }

      it_behaves_like "a successful response"
    end

    context "invalid stack" do
      let(:response) { endpoint.update("example-app", stack_id: "stack-not-found") }
      let(:stub_pattern) { "update-stack-404" }

      it_behaves_like "a not found response"
    end
  end

  context "logs_url" do
    let(:response) { endpoint.logs_url("example-app") }

    context "success" do
      let(:stub_pattern) { "logs_url" }

      it_behaves_like "a successful response"
    end
  end

  context "destroy" do
    context "success" do
      let(:response) { endpoint.destroy("example-app", current_name: "example-app") }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "a successful response", 204
    end

    context "not found" do
      let(:response) { endpoint.destroy("example-app-2") }
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end

    context "unprocessable" do
      let(:response) { endpoint.destroy("example-app", current_name: "wrong-name") }
      let(:stub_pattern) { "destroy-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  context "rename" do
    context "success" do
      let(:response) { endpoint.rename("example-app", current_name: "example-app", new_name: "example-app-2") }
      let(:stub_pattern) { "rename-200" }

      it_behaves_like "a successful response"
    end

    context "not found" do
      let(:response) { endpoint.rename("example-app", current_name: "example-app", new_name: "example-app-2") }
      let(:stub_pattern) { "rename-404" }

      it_behaves_like "a not found response"
    end

    context "unprocessable" do
      let(:response) { endpoint.rename("example-app", current_name: "example-app", new_name: "example-app--") }
      let(:stub_pattern) { "rename-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  context "transfer" do
    context "success" do
      let(:response) { endpoint.transfer("example-app", current_name: "example-app", app: {owner: "user@example.com"}) }
      let(:stub_pattern) { "transfer-200" }

      it_behaves_like "a successful response"
    end

    context "not found" do
      let(:response) { endpoint.transfer("example-app", current_name: "example-app", app: {owner: "user@example.com"}) }
      let(:stub_pattern) { "transfer-404" }

      it_behaves_like "a not found response"
    end

    context "unprocessable" do
      let(:response) { endpoint.transfer("example-app", current_name: "example-app", app: {owner: "user@example.com"}) }
      let(:stub_pattern) { "transfer-422" }

      it_behaves_like "an unprocessable request"
    end
  end
end
