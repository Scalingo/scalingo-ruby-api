require "spec_helper"

RSpec.describe Scalingo::Auth::TwoFactorAuth, type: :endpoint do
  describe "status" do
    subject(:response) { instance.status(**arguments) }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:get, api_path.merge("/client/tfa")) }
  end

  describe "initiate" do
    subject(:response) { instance.initiate(**arguments) }

    let(:body) { {provider: "value"} }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:post, api_path.merge("/client/tfa")).with(body: {tfa: body}) }
  end

  describe "validate" do
    subject(:response) { instance.validate(**arguments) }

    let(:body) { {attempt: "value"} }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:post, api_path.merge("/client/tfa/validate")).with(body: {tfa: body}) }
  end

  describe "disable" do
    subject(:response) { instance.disable(**arguments) }

    include_examples "requires authentication"

    it { is_expected.to have_requested(:delete, api_path.merge("/client/tfa")) }
  end
end
