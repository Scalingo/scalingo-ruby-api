require "spec_helper"

RSpec.describe Scalingo::Regional::Containers do
  describe_method "sizes" do
    context "guest" do
      subject { guest_endpoint }

      let(:expected_count) { 7 }
      let(:stub_pattern) { "sizes-guest" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end

    context "logged" do
      let(:expected_count) { 7 }
      let(:stub_pattern) { "sizes-logged" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  describe_method "for" do
    context "success" do
      let(:arguments) { meta[:app_id] }
      let(:expected_count) { 2 }
      let(:expected_keys) { %i[name] }
      let(:stub_pattern) { "for-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  describe_method "restart" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:restart][:valid]] }
      let(:stub_pattern) { "restart-202" }

      it_behaves_like "a singular object response", 202
    end

    context "success" do
      let(:arguments) { [meta[:app_id], meta[:restart][:invalid]] }
      let(:stub_pattern) { "restart-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  describe_method "scale" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:scale][:valid]] }
      let(:stub_pattern) { "scale-202" }

      it_behaves_like "a singular object response", 202
    end

    context "success" do
      let(:arguments) { [meta[:app_id], meta[:scale][:invalid]] }
      let(:stub_pattern) { "scale-422" }

      it_behaves_like "an unprocessable request"
    end
  end
end
