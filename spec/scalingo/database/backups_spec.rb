require "spec_helper"

RSpec.describe Scalingo::Database::Backups, type: :endpoint do
  let(:addon_id) { "the-addon-id" }

  describe "list" do
    subject(:response) { instance.list(**arguments) }

    let(:params) { {addon_id: addon_id} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :addon_id

    it { is_expected.to have_requested(:get, api_path.merge("/databases/the-addon-id/backups")) }
  end

  describe "create" do
    subject(:response) { instance.create(**arguments) }

    let(:params) { {addon_id: addon_id} }
    let(:body) { {field: "value"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :addon_id

    it { is_expected.to have_requested(:post, api_path.merge("/databases/the-addon-id/backups")) }
  end

  describe "archive" do
    subject(:response) { instance.archive(**arguments) }

    let(:params) { {addon_id: addon_id, id: "backup-id"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :addon_id, :id

    it { is_expected.to have_requested(:get, api_path.merge("/databases/the-addon-id/backups/backup-id/archive")) }
  end
end
