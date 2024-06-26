require "spec_helper"

RSpec.describe Scalingo::Database::Databases, type: :endpoint do
  let(:id) { "database-id" }

  describe "find" do
    subject(:response) { instance.find(**arguments) }

    let(:params) { {id: id} }

    include_examples "requires authentication"
    include_examples "requires some params", :id

    it { is_expected.to have_requested(:get, api_path.merge("/databases/database-id")) }
  end

  describe "upgrade" do
    subject(:response) { instance.upgrade(**arguments) }

    let(:params) { {id: id} }

    include_examples "requires authentication"
    include_examples "requires some params", :id

    it { is_expected.to have_requested(:post, api_path.merge("/databases/database-id/upgrade")) }
  end
end
