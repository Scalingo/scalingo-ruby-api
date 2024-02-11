require "spec_helper"

RSpec.describe Scalingo::Regional::Apps do
  describe_method "all" do
    let(:expected_count) { 2 }
    let(:stub_pattern) { "all" }

    it_behaves_like "a collection response"
    it_behaves_like "a non-paginated collection"
  end

  describe_method "create" do
    context "success" do
      let(:body) { meta[:create][:valid] }
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a singular object response", 201
    end

    context "dry run" do
      let(:params) { {dry_run: true} }
      let(:body) { meta[:create][:valid] }
      let(:stub_pattern) { "create-201-dry-run" }

      it_behaves_like "a singular object response", 201
    end

    context "failure" do
      let(:body) { meta[:create][:invalid] }
      let(:stub_pattern) { "create-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  describe_method "find" do
    context "success" do
      let(:params) { meta.slice(:id) }
      let(:stub_pattern) { "find-200" }

      it_behaves_like "a singular object response"
    end

    context "not found" do
      let(:params) { {id: meta[:not_found_id]} }
      let(:stub_pattern) { "find-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "update" do
    context "success" do
      let(:params) { meta.slice(:id) }
      let(:body) { meta[:update][:valid] }
      let(:stub_pattern) { "update-200" }

      it_behaves_like "a singular object response"
    end

    context "invalid stack" do
      let(:params) { meta.slice(:id) }
      let(:body) { meta[:update][:invalid] }
      let(:stub_pattern) { "update-stack-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "logs_url" do
    context "success" do
      let(:params) { meta.slice(:id) }
      let(:stub_pattern) { "logs_url" }
      let(:expected_keys) { %i[app logs_url] }

      it_behaves_like "a singular object response"
    end
  end

  describe_method "destroy" do
    context "success" do
      let(:params) { meta.slice(:id) }
      let(:body) { meta[:destroy][:valid] }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "an empty response"
    end

    context "not found" do
      let(:params) { {id: meta[:not_found_id]} }
      let(:body) { meta[:destroy][:valid] }
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end

    context "unprocessable" do
      let(:params) { meta.slice(:id) }
      let(:body) { meta[:destroy][:invalid] }
      let(:stub_pattern) { "destroy-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  describe_method "rename" do
    context "success" do
      let(:params) { meta.slice(:id) }
      let(:body) { meta[:rename][:valid] }
      let(:stub_pattern) { "rename-200" }

      it_behaves_like "a singular object response"
    end

    context "not found" do
      let(:params) { {id: meta[:not_found_id]} }
      let(:body) { meta[:rename][:valid] }
      let(:stub_pattern) { "rename-404" }

      it_behaves_like "a not found response"
    end

    context "unprocessable" do
      let(:params) { meta.slice(:id) }
      let(:body) { meta[:rename][:invalid] }
      let(:stub_pattern) { "rename-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  describe_method "transfer" do
    context "success" do
      let(:params) { meta.slice(:id) }
      let(:body) { meta[:transfer][:valid] }
      let(:stub_pattern) { "transfer-200" }

      it_behaves_like "a singular object response"
    end

    context "not found" do
      let(:params) { {id: meta[:not_found_id]} }
      let(:body) { meta[:transfer][:valid] }
      let(:stub_pattern) { "transfer-404" }

      it_behaves_like "a not found response"
    end

    context "unprocessable" do
      let(:params) { meta.slice(:id) }
      let(:body) { meta[:transfer][:invalid] }
      let(:stub_pattern) { "transfer-422" }

      it_behaves_like "an unprocessable request"
    end
  end
end
