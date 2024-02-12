require "spec_helper"

RSpec.describe Scalingo::RegionalDatabase::Backups do
  before do
    scalingo.add_database_token(meta[:addon_id], "the-bearer-token")
  end

  describe_method "create" do
    context "success" do
      let(:params) { meta.slice(:addon_id) }
      let(:stub_pattern) { "create-201" }

      it_behaves_like "a singular object response", 201
    end

    context "failure" do
      let(:params) { meta.slice(:addon_id) }
      let(:stub_pattern) { "create-400" }

      it_behaves_like "a client error"
    end
  end

  describe_method "for" do
    context "success" do
      let(:params) { meta.slice(:addon_id) }
      let(:stub_pattern) { "for-200" }
      let(:expected_count) { 3 }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end

    context "failure" do
      let(:params) { meta.slice(:addon_id) }
      let(:stub_pattern) { "for-400" }

      it_behaves_like "a client error"
    end
  end

  describe_method "archive" do
    context "success" do
      let(:params) { meta.slice(:addon_id, :id) }
      let(:stub_pattern) { "archive-200" }
      let(:expected_keys) { %i[download_url] }

      it_behaves_like "a singular object response"
    end

    context "failure" do
      let(:params) { meta.slice(:addon_id, :id) }
      let(:stub_pattern) { "archive-400" }

      it_behaves_like "a client error"
    end
  end
end
