require "spec_helper"

RSpec.describe Scalingo::Auth::TwoFactorAuth, type: :endpoint do
  describe "status" do
    subject(:response) { instance.status(**arguments) }

    it_behaves_like "requires authentication"

    it { is_expected.to have_requested(:get, api_path.merge("/client/tfa")) }
  end

  describe "initiate" do
    subject(:response) { instance.initiate(**arguments) }

    let(:body) { {provider: "value"} }

    it_behaves_like "requires authentication"

    it { is_expected.to have_requested(:post, api_path.merge("/client/tfa")).with(body: {tfa: body}) }
  end

  describe "validate" do
    subject(:response) { instance.validate(**arguments) }

    let(:body) { {attempt: "value"} }

    it_behaves_like "requires authentication"

    it { is_expected.to have_requested(:post, api_path.merge("/client/tfa/validate")).with(body: {tfa: body}) }
  end

  describe "disable" do
    subject(:response) { instance.disable(**arguments) }

    it_behaves_like "requires authentication"

    it { is_expected.to have_requested(:delete, api_path.merge("/client/tfa")) }
  end
end
