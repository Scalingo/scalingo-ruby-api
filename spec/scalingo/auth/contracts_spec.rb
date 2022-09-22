require "spec_helper"

RSpec.describe Scalingo::Auth::Contracts do
  describe_method "all" do
    let(:stub_pattern) { "all-200" }

    it_behaves_like "a collection response"
    it_behaves_like "a non-paginated collection"
  end
end
