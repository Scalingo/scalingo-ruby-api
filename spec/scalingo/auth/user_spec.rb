require "spec_helper"

RSpec.describe Scalingo::Auth::User do
  describe_method "self" do
    let(:stub_pattern) { "self" }

    it_behaves_like "a singular object response"
  end

  describe_method "update" do
    context "success" do
      let(:body) { meta[:update][:valid] }
      let(:stub_pattern) { "update-200" }

      it_behaves_like "a singular object response"
    end

    context "unprocessable" do
      let(:body) { meta[:update][:invalid] }
      let(:stub_pattern) { "update-422" }

      it_behaves_like "an unprocessable request"
    end
  end

  describe_method "stop_free_trial" do
    let(:stub_pattern) { "stop-free-trial" }

    it_behaves_like "a successful response"
  end
end
