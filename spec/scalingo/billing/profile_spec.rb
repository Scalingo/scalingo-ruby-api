require "spec_helper"

RSpec.describe Scalingo::Billing::Profile, type: :endpoint do
  describe "create" do
    subject(:response) { instance.create(**arguments) }

    let(:body) { {field: "value"} }

    it_behaves_like "requires authentication"

    it { is_expected.to have_requested(:post, api_path.merge("/profiles")).with(body: {profile: body}) }
  end

  describe "find" do
    subject(:response) { instance.find(**arguments) }

    it_behaves_like "requires authentication"

    it { is_expected.to have_requested(:get, api_path.merge("/profile")) }
  end

  describe "update" do
    subject(:response) { instance.update(**arguments) }

    let(:params) { {id: "profile-id"} }
    let(:body) { {field: "value"} }

    it_behaves_like "requires authentication"
    it_behaves_like "requires some params", :id

    it { is_expected.to have_requested(:put, api_path.merge("/profiles/profile-id")).with(body: {profile: body}) }
  end
end
