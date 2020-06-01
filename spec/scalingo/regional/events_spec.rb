require "spec_helper"

RSpec.describe Scalingo::Regional::Events do
  describe_method "categories" do
    context "guest" do
      subject { guest_endpoint }

      let(:expected_count) { 7 }
      let(:stub_pattern) { "categories-guest" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end

    context "logged" do
      let(:expected_count) { 7 }
      let(:stub_pattern) { "categories-logged" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  describe_method "types" do
    context "guest" do
      subject { guest_endpoint }

      let(:expected_count) { 33 }
      let(:stub_pattern) { "types-guest" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end

    context "logged" do
      let(:expected_count) { 33 }
      let(:stub_pattern) { "types-logged" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  describe_method "all" do
    context "success" do
      let(:arguments) { {} }
      let(:expected_count) { 30 }
      let(:stub_pattern) { "all-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a paginated collection"
    end
  end

  describe_method "for" do
    context "success" do
      let(:arguments) { [meta[:app_id], {}] }
      let(:expected_count) { 18 }
      let(:stub_pattern) { "for-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a paginated collection"
    end
  end
end
