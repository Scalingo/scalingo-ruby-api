require "spec_helper"

RSpec.describe Scalingo::Regional::Events do
  let(:endpoint) { regional.events }
  let(:guest_endpoint) { regional_guest.events }

  context "categories" do
    context "guest" do
      let(:response) { guest_endpoint.categories }
      let(:expected_count) { 7 }
      let(:stub_pattern) { "categories-guest" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end

    context "logged" do
      let(:response) { endpoint.categories }
      let(:expected_count) { 7 }
      let(:stub_pattern) { "categories-logged" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  context "types" do
    context "guest" do
      let(:response) { guest_endpoint.types }
      let(:expected_count) { 33 }
      let(:stub_pattern) { "types-guest" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end

    context "logged" do
      let(:response) { endpoint.types }
      let(:expected_count) { 33 }
      let(:stub_pattern) { "types-logged" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  context "all" do
    context "success" do
      let(:response) { endpoint.all }
      let(:expected_count) { 30 }
      let(:stub_pattern) { "all-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a paginated collection"
    end
  end

  context "for" do
    context "success" do
      let(:response) { endpoint.for(meta[:app_id]) }
      let(:expected_count) { 18 }
      let(:stub_pattern) { "for-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a paginated collection"
    end
  end
end
