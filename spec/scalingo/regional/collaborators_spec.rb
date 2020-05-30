require "spec_helper"

RSpec.describe Scalingo::Regional::Collaborators do
  let(:endpoint) { regional.collaborators }

  context "for" do
    context "success" do
      let(:response) { endpoint.for(meta[:app_id]) }
      let(:stub_pattern) { "for-200" }

      it_behaves_like "a collection response"
      it_behaves_like "a non-paginated collection"
    end
  end

  context "invite" do
    context "success" do
      let(:response) { endpoint.invite(meta[:app_id], meta[:invite][:valid]) }
      let(:stub_pattern) { "invite-201" }

      it_behaves_like "a successful response", 201
    end

    context "failure" do
      let(:response) { endpoint.invite(meta[:app_id], meta[:invite][:invalid]) }
      let(:stub_pattern) { "invite-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  context "accept" do
    context "success" do
      let(:response) { endpoint.accept(meta[:accept][:valid]) }
      let(:stub_pattern) { "accept-200" }

      it_behaves_like "a successful response"
    end

    context "already collaborating" do
      let(:response) { endpoint.accept(meta[:accept][:valid]) }
      let(:stub_pattern) { "accept-400" }

      it_behaves_like "a client error"
    end

    context "not found" do
      let(:response) { endpoint.accept(meta[:accept][:invalid]) }
      let(:stub_pattern) { "accept-404" }

      it_behaves_like "a not found response"
    end
  end

  context "destroy" do
    context "success" do
      let(:response) { endpoint.destroy(meta[:app_id], meta[:id]) }
      let(:stub_pattern) { "destroy-204" }

      it_behaves_like "a successful response", 204
    end

    context "not found" do
      let(:response) { endpoint.destroy(meta[:app_id], meta[:not_found_id]) }
      let(:stub_pattern) { "destroy-404" }

      it_behaves_like "a not found response"
    end
  end
end
