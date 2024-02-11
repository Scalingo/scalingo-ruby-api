require "spec_helper"

RSpec.describe Scalingo::Regional::Deployments do
  describe_method "for" do
    context "success" do
      let(:params) { meta.slice(:app_id) }

      context "with pages" do
        let(:params) { meta.slice(:app_id).merge(query: {page: 3}) }
        let(:stub_pattern) { "for-with-pages" }

        it_behaves_like "a collection response"
        it_behaves_like "a paginated collection"
      end

      context "without pages" do
        let(:stub_pattern) { "for-without-pages" }

        it_behaves_like "a collection response"
        it_behaves_like "a paginated collection"
      end
    end
  end

  describe_method "find" do
    context "success" do
      let(:params) { meta.slice(:app_id, :id) }
      let(:stub_pattern) { "find-200" }

      it_behaves_like "a singular object response"
    end

    context "failure" do
      let(:params) { meta.slice(:app_id).merge(id: meta[:not_found_id]) }
      let(:stub_pattern) { "find-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "logs" do
    context "success" do
      let(:params) { meta.slice(:app_id, :id) }
      let(:stub_pattern) { "logs-200" }

      it_behaves_like "a singular object response"
    end

    context "failure" do
      let(:params) { meta.slice(:app_id).merge(id: meta[:not_found_id]) }
      let(:stub_pattern) { "logs-404" }

      it_behaves_like "a not found response"
    end
  end
end
