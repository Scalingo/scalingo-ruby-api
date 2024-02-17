require "spec_helper"

RSpec.describe Scalingo::RegionalDatabase::Backups, type: :endpoint do
  let(:addon_id) { "the-addon-id" }

  before do
    scalingo_client.add_database_token(addon_id, "the-bearer-token")
  end

  describe "for" do
    subject(:response) { instance.for(**arguments) }

    let(:params) { {addon_id: addon_id} }

    include_examples "requires authentication"
    include_examples "requires some params", :addon_id

    it { is_expected.to have_requested(:get, api_path.merge("/databases/the-addon-id/backups")) }
  end

  describe "create" do
    subject(:response) { instance.create(**arguments) }

    let(:params) { {addon_id: addon_id} }
    let(:body) { {field: "value"} }

    include_examples "requires authentication"
    include_examples "requires some params", :addon_id

    it { is_expected.to have_requested(:post, api_path.merge("/databases/the-addon-id/backups")) }
  end

  describe "archive" do
    subject(:response) { instance.archive(**arguments) }

    let(:params) { {addon_id: addon_id, id: "backup-id"} }

    include_examples "requires authentication"
    include_examples "requires some params", :addon_id, :id

    it { is_expected.to have_requested(:get, api_path.merge("/databases/the-addon-id/backups/backup-id/archive")) }
  end
end
