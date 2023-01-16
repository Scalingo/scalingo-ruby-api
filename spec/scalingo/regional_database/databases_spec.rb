require "spec_helper"

RSpec.describe Scalingo::RegionalDatabase::Databases do
  before do
    scalingo.add_database_token(meta[:id], "the-bearer-token")
  end

  describe_method "find" do
    context "success" do
      let(:arguments) { [meta[:id]] }
      let(:stub_pattern) { "find-200" }

      it_behaves_like "a singular object response"
    end

    context "failure" do
      let(:arguments) { [meta[:id]] }
      let(:stub_pattern) { "find-400" }

      it_behaves_like "a client error"
    end
  end

  describe_method "upgrade" do
    context "success" do
      let(:arguments) { [meta[:id]] }
      let(:stub_pattern) { "upgrade-202" }

      it_behaves_like "a singular object response", 202
    end

    context "failure" do
      let(:arguments) { [meta[:id]] }
      let(:stub_pattern) { "upgrade-400" }

      it_behaves_like "a client error"
    end
  end
end
