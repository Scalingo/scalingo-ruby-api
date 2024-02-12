require "spec_helper"

RSpec.describe Scalingo::Regional::Collaborators do
  describe_method "for" do
    context "success" do
      let(:arguments) { meta[:app_id] }
      let(:stub_pattern) { "for-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  describe_method "invite" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:invite][:valid]] }
      let(:stub_pattern) { "invite-201" }

      it_behaves_like "a singular object response", 201
    end

    context "failure" do
      let(:arguments) { [meta[:app_id], meta[:invite][:invalid]] }
      let(:stub_pattern) { "invite-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  describe_method "accept" do
    context "success" do
      let(:arguments) { meta[:accept][:valid] }
      let(:stub_pattern) { "accept-200" }

      it_behaves_like "a singular object response"
    end

    context "already collaborating" do
      let(:arguments) { meta[:accept][:valid] }
      let(:stub_pattern) { "accept-400" }

      it_behaves_like "a client error"
    end

    context "not found" do
      let(:arguments) { meta[:accept][:invalid] }
      let(:stub_pattern) { "accept-404" }

      it_behaves_like "a not found response"
    end
  end

  describe_method "destroy" do
    context "success" do
      let(:arguments) { [meta[:app_id], meta[:id]] }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "an empty response"
    end

    context "not found" do
      let(:arguments) { [meta[:app_id], meta[:not_found_id]] }
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end
  end
end
