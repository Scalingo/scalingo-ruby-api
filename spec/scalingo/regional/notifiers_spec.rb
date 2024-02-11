require "spec_helper"

RSpec.describe Scalingo::Regional::Notifiers do
  describe_method "platforms" do
    context "guest" do
      let(:params) { {connected: false} }
      let(:expected_count) { 4 }
      let(:stub_pattern) { "platforms-guest" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end

    context "logged" do
      let(:params) { {connected: true} }
      let(:expected_count) { 4 }
      let(:stub_pattern) { "platforms-logged" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  describe_method "for" do
    context "success" do
      let(:params) { meta.slice(:app_id) }
      let(:stub_pattern) { "for-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  describe_method "find" do
    context "success" do
      let(:params) { meta.slice(:app_id, :id) }
      let(:stub_pattern) { "find-200" }

      it_behaves_like "a singular object response"
    end

    context "not found" do
      let(:params) { meta.slice(:app_id).merge(id: meta[:not_found_id]) }
      let(:stub_pattern) { "find-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "create" do
    context "success" do
      let(:params) { meta.slice(:app_id) }
      let(:body) { meta[:create][:valid] }
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a singular object response", 201
    end

    context "not found" do
      let(:params) { meta.slice(:app_id) }
      let(:body) { meta[:create][:not_found] }
      let(:stub_pattern) { "create-404" }

      it_behaves_like "a not found response"
    end

    context "failure" do
      let(:params) { meta.slice(:app_id) }
      let(:body) { meta[:create][:invalid] }
      let(:stub_pattern) { "create-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  describe_method "test" do
    context "success" do
      let(:params) { meta.slice(:app_id, :id) }
      let(:stub_pattern) { "test-200" }

      it_behaves_like "a singular object response"
    end

    context "not found" do
      let(:params) { meta.slice(:app_id).merge(id: meta[:not_found_id]) }
      let(:stub_pattern) { "test-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "update" do
    context "success" do
      let(:params) { meta.slice(:app_id, :id) }
      let(:body) { meta[:update][:valid] }
      let(:stub_pattern) { "update-200" }

      it_behaves_like "a singular object response"
    end
  end

  describe_method "destroy" do
    context "success" do
      let(:params) { meta.slice(:app_id, :id) }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "an empty response"
    end

    context "not found" do
      let(:params) { meta.slice(:app_id).merge(id: meta[:not_found_id]) }
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end
  end
end
